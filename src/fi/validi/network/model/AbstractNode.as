package fi.validi.network.model {
	import fi.validi.network.VectorOperations;
	import fi.validi.network.model.model2d.Node2D;

	/**
	 * @author jiv
	 */
	public class AbstractNode implements INode {
		
		private static var _IDCounter : uint = 1;
		private var _ID : uint;
		private var _networks : Vector.<INetwork>;
		private var _inEdges : Vector.<IEdge>;
		private var _outEdges : Vector.<IEdge>;
		
		public function AbstractNode(toNetworks : Vector.<INetwork>) {
			_ID = _IDCounter;
			_IDCounter++;
			networks = toNetworks;
			_inEdges = new Vector.<IEdge>();
			_outEdges = new Vector.<IEdge>();
			trace("Node " + _ID + " created to networks: " + networks[0]);
		}

		private function addToNetworks(networks : Vector.<INetwork>) : void {
			for each (var network : INetwork in networks) {
				network.addNode(this);
				addToNetwork(network);
			}
		}

		private function addToNetwork(network : INetwork) : void {
			network.addNode(this);
			//networks = Vector.<INetwork>(networks.push(network));
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
			if(_networks) {
				var nodeRemovedFromNetworks : Vector.<INetwork> = Vector.<INetwork>(VectorOperations.difference(Vector.<INetObject>(_networks), Vector.<INetObject>(networks)));
				trace("node removed from networks : " + nodeRemovedFromNetworks);
				for each (var network : INetwork in nodeRemovedFromNetworks) {
					if(network.nodes.length == 0) {
						network = null;
					}
				}
			}
			_networks = networks;
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
		
		public function toString() : String {
			return String(ID);
		}

		public function get inEdges() : Vector.<IEdge> {
			return _inEdges;
		}

		public function get outEdges() : Vector.<IEdge> {
			return _outEdges;
		}

	}
}
