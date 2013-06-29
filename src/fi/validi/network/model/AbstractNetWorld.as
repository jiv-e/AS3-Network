package fi.validi.network.model {
	import fi.validi.network.VectorOperations;
	import flash.events.EventDispatcher;

	/**
	 * @author jiv
	 */
	public class AbstractNetWorld extends EventDispatcher implements INetWorld {
		protected var _networks : Vector.<INetwork>;
		protected var _nodes : Vector.<INode>;
		protected var _edges : Vector.<IEdge>;
		
		public function AbstractNetWorld() {
			_nodes = new Vector.<INode>;
			_edges = new Vector.<IEdge>;
			_networks = new Vector.<INetwork>;
		}

		public function createEdge(nodesInOut : Vector.<INode>, nodesIn : Vector.<INode> = null, nodesOut : Vector.<INode> = null) : IEdge {
			//TODO validate edge creation to avoid corrupted data.	
			var createdEdge : Edge = new Edge(nodesInOut, nodesIn, nodesOut, NetworkIDCascadeType.ORDINALITY);
			_edges.push(createdEdge);
			dispatchEvent(new NetWorldEvent(NetWorldEvent.EDGE_CREATED, createdEdge));
			
			//Order networks connected to this edge by ID - smallest ID first 					
			var orderedNetworks : Vector.<INetwork> = createdEdge.connectedNetworks.sort(VectorOperations.compare);
			
			//Add this edge to some network
			createdEdge.addToNetwork(orderedNetworks[0]);
			
			//If this edge connects different networks engulf the others
			if (orderedNetworks.length > 1) {
				engulfNetworks(orderedNetworks[0], Vector.<INetwork>(orderedNetworks.slice(1)));
			}
			
			return createdEdge;
		}
		
		public function destroyEdge(edge : IEdge) : void {
			edge.destroy();
		}
		
		public function createNetwork() : INetwork {
			var createdNetwork : Network = new Network(this);
			_networks.push(createdNetwork);
			dispatchEvent(new NetWorldEvent(NetWorldEvent.NETWORK_CREATED, createdNetwork));
			return createdNetwork;
		}

		public function get nodes() : Vector.<INode> {
			return _nodes;
		}

		public function get edges() : Vector.<IEdge> {
			return _edges;
		}
		
		public function destroyAllEdges() : void {
			for each (var edge : IEdge in _edges) {
				edge.destroy();
			}
		}

		public function get networks() : Vector.<INetwork> {
			return _networks;
		}

		public function createEdgeInOut(node1 : INode, node2 : INode) : void {
			var v1 : Vector.<INode> = new Vector.<INode>;

			v1.push(node1);
			v1.push(node2);
			createEdge(v1);						
		}

		public function createRandomInOutEdge() : void {
			if (validateEdges(edges.length + 1)) {
				var n1 : INode;
				var n2 : INode;
				do {
					n1 = nodes[Math.floor(Math.random() * nodes.length)];
					n2 = nodes[Math.floor(Math.random() * nodes.length)];
				} while (n1.isNeighbour(n2));
				createEdgeInOut(n1, n2);
			}
		}
		
		private function validateEdges(edges : Number):Boolean {
			var okNumOfEdges : Boolean = edges <= (nodes.length * (nodes.length - 1)) / 2;
			if (!okNumOfEdges) {
				trace("Too many edges!");
//				_edgesStepper.value = NodeSprite.nodeCount * (NodeSprite.nodeCount + 1) / 2;
			}
			return okNumOfEdges;
		}

		protected function createSingleNetworkVector(network : INetwork = null) : Vector.<INetwork> {
			var networkVector : Vector.<INetwork> = new Vector.<INetwork>();
			if(network != null) networkVector.push(network);
			else networkVector.push(createNetwork());
			return networkVector;
		}

		protected function initNodeCreation(node : INode) : INode {			
			_nodes.push(node);
			dispatchEvent(new NetWorldEvent(NetWorldEvent.NODE_CREATED, node));
			node.addEventListener(NodeEvent.REMOVED_FROM_NETWORKS, nodeRemovedFromNetworksListener);
			return node;
		}
		
		private function nodeRemovedFromNetworksListener(event : NodeEvent) : void {
			if(event.netObjects) {
				_networks = Vector.<INetwork>(VectorOperations.difference(Vector.<INetObject>(_networks), event.netObjects));
				dispatchEvent(new NetWorldEvent(NetWorldEvent.NETWORKS_CHANGED));
			}
		}
		
		private function destroyNetwork(network : INetwork) : void {

		}
		
		private function engulfNetwork(engulfer : INetwork, engulfed : INetwork) : void {
			for each (var edge : IEdge in engulfed.edges) {
				 edge.networks = new Vector.<INetwork>();
				 edge.addToNetwork(engulfer);
			}
			for each (var node : INode in engulfed.nodes) {
				node.networks = createSingleNetworkVector(engulfer);
			}
			trace("Network " + engulfer + " engulfed the network " + engulfed + ".");
		}
		
		private function engulfNetworks(engulfer : INetwork, engulfed : Vector.<INetwork>) : void {
			for each (var network : INetwork in engulfed) {
				engulfNetwork(engulfer, network);
			}
		}

	}
}
