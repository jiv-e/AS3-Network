package fi.validi.network.model {
	import flash.events.EventDispatcher;
	import fi.validi.network.VectorOperations;
	import fi.validi.network.model.model2d.Node2D;

	/**
	 * @author jiv
	 */
	public class AbstractNode extends EventDispatcher implements INode {
		protected static var _IDCounter : uint = 1;
		protected var _ID : uint;
		protected var _networks : Vector.<INetwork>;
		protected var _inEdges : Vector.<IEdge>;
		protected var _outEdges : Vector.<IEdge>;
		protected var _netWorld : INetWorld;
		
		private var eventDispatcher : EventDispatcher;
		
		public function AbstractNode(toNetWorld : INetWorld, toNetworks : Vector.<INetwork>) {
			_ID = _IDCounter;
			_IDCounter++;
			_netWorld = toNetWorld;
			networks = toNetworks;
			_inEdges = new Vector.<IEdge>();
			_outEdges = new Vector.<IEdge>();
			
			eventDispatcher = new EventDispatcher();
			
			trace("Node " + _ID + " created to net world " + netWorld + " and networks: " + networks[0]);
		}

		public function addToNetworks(networks : Vector.<INetwork>) : void {
			for each (var network : INetwork in networks) {
				addToNetwork(network);
			}
		}

		public function addToNetwork(network : INetwork) : void {
			network.addNode(this);
			networks.push(network);
		}

		public function detatch() : void {
		}

		//public function connect(edge : IEdge, connectionType : String) : void {
		public function connectInEdge(edge : IEdge) : void {
			inEdges.push(edge);
		}

		public function connectOutEdge(edge : IEdge) : void {
			outEdges.push(edge);
		}

		private function nodeInListener(event : Node2D) : void {
			trace("");
		}

		public function get networks() : Vector.<INetwork> {
			return _networks;
		}

		public function set networks(networks : Vector.<INetwork>) : void {
			if (_networks && !VectorOperations.isEqual(Vector.<INetObject>(_networks), Vector.<INetObject>(networks))) {
				var nodeRemovedFromNetworks : Vector.<INetwork> = Vector.<INetwork>(VectorOperations.difference(Vector.<INetObject>(_networks), Vector.<INetObject>(networks)));
				trace("node removed from networks : " + nodeRemovedFromNetworks);
				dispatchEvent(new NodeEvent(NodeEvent.REMOVED_FROM_NETWORKS, Vector.<INetObject>(nodeRemovedFromNetworks)));
			}
			_networks = new Vector.<INetwork>();
			addToNetworks(networks);
		}

		public function get networkIDs() : Vector.<uint> {
			var _networkIDs : Vector.<uint> = new Vector.<uint>();
			for each (var network : INetwork in networks) {
				_networkIDs.push(network.ID);
			}
			return _networkIDs;
		}

		public function destroy() : void {
		}

		public function sendEffect(effect : IEffect) : void {
		}

		public function enable() : void {
		}

		public function disable() : void {
		}

		public function get ID() : uint {
			return _ID;
		}
		
		public function isNeighbour(node : INode) : Boolean {
			//At the moment every node is itselfs neighbour.
			if(node == this) return true;
			
			for each (var edge : IEdge in _outEdges) {
				for each (var needle : INode in edge.nodesOut.concat(edge.nodesInOut)) {
					if(needle == node) {
						return true;
					}
				}
			}
			return false;
		}
		
		override public function toString() : String {
			return String(super.toString() + " ID: " + ID);
		}

		public function get inEdges() : Vector.<IEdge> {
			return _inEdges;
		}

		public function get outEdges() : Vector.<IEdge> {
			return _outEdges;
		}

		public function activate() : void {
			dispatchEvent(new NetWorldEvent(NetWorldEvent.ACTIVATED, this));
		}

		public function deactivate() : void {
			dispatchEvent(new NetWorldEvent(NetWorldEvent.DEACTIVATED, this));
		}

		public function get netWorld() : INetWorld {
			return _netWorld;
		}

	}
}

