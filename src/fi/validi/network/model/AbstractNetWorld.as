package fi.validi.network.model {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author jiv
	 */
	public class AbstractNetWorld extends EventDispatcher {
		protected var _networks : Vector.<INetwork>;
		protected var _nodes : Vector.<INode>;
		protected var _edges : Vector.<IEdge>;
		protected var _createdNode : INode;
		protected var _createdEdge : IEdge;
		protected var _createdNetwork : INetwork;
		
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
			return createdEdge;
		}
		
		public function createNetwork() : INetwork {
			var createdNetwork : Network = new Network();
			_networks.push(_createdNetwork);
			dispatchEvent(new NetWorldEvent(NetWorldEvent.NETWORK_CREATED, createdNetwork));
			return createdNetwork;
		}

		public function get nodes() : Vector.<INode> {
			return _nodes;
		}

		public function get createdNode() : INode {
			return _createdNode;
		}

		public function get createdEdge() : IEdge {
			return _createdEdge;
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

		protected function createSingleNetworkVector() : Vector.<INetwork> {
			var networkVector : Vector.<INetwork> = new Vector.<INetwork>();
			networkVector.push(createNetwork());
			return networkVector;
		}

		protected function initNodeCreation(node : INode) : void {			
			_nodes.push(node);
			dispatchEvent(new NetWorldEvent(NetWorldEvent.NODE_CREATED, node));
		}
		
		private function destroyNetwork(network : INetwork) : void {
			
		}
		

	}
}
