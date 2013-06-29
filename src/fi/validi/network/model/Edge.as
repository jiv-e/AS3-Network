package fi.validi.network.model {
	import fi.validi.network.VectorOperations;
	import flash.events.EventDispatcher;

	/**
	 * @author Juho Viitasalo
	 */
	public class Edge extends EventDispatcher implements IEdge {
		
		private static var _IDCounter : uint = 1;
		private var _nodesIn : Vector.<INode>;
		private var _nodesOut : Vector.<INode>;
		private var _nodesInOut : Vector.<INode>;
		private var _networks : Vector.<INetwork>;
		private var _ID : uint;
		
		public function Edge(inOut : Vector.<INode>, inTo : Vector.<INode> = null, outFrom : Vector.<INode> = null, networkIDCascadeType : String = NetworkIDCascadeType.ORDINALITY) {
			if (inOut[1] || (inTo[0] && outFrom[0])) {
				_ID = _IDCounter;
				_IDCounter++;
				if(inOut) {
					_nodesInOut = inOut;
					trace("Nodes " + inOut + " connected!");
				}
				else _nodesInOut = new Vector.<INode>();
				
				if(inTo) {
					_nodesIn = inTo;
				}
				else _nodesIn = new Vector.<INode>();
				
				if(outFrom) {
					_nodesOut = outFrom;
				}
				else _nodesOut = new Vector.<INode>();
				
				_networks = new Vector.<INetwork>;
				updateNodes();

//				switch(networkIDCascadeType) {
//					case NetworkIDCascadeType.ORDINALITY:
//					
//						//Choose the network with smallest networkID for this edge and for all
//						//the connected edges and nodes
//						var networkWithSmallestID : INetwork = findNetworkWithSmallestID(ConnectionType.INOUT);
//						//Add this edge to the network
//						addToNetwork(networkWithSmallestID);
//						//Get all the nodes and edges from the old network and move them to
//						//the new network.
//						var networkVector : Vector.<INetwork> = new Vector.<INetwork>();
//						networkVector.push(networkWithSmallestID);
//						setNodeNetworks(networkVector, ConnectionType.INOUT);			
//						break;
//					case NetworkIDCascadeType.CARDINALITY:
//					
//						break;
//					case NetworkIDCascadeType.UNION:
//					
//						break;
//					default:
//				}			
			}
			else {
				trace("Error: Edge has to have at least one 'in to' and 'out from' node.");
				
			}
		}

		private function engulfNetwork(engulfer : INetwork, engulfed : INetwork) : void {
			
		}

		private function updateNodes() : void {
			for each (var nodeIn : INode in nodesIn.concat(nodesInOut)) {
				nodeIn.connectInEdge(this);
			}
			for each (var nodeOut : INode in nodesOut.concat(nodesInOut)) {
				nodeOut.connectOutEdge(this);
			}
		}

		public function addToNetwork(network : INetwork) : void {
			_networks.push(network);
			network.addEdge(this);
		}
		
		public function addToNetworks(networks : Vector.<INetwork>) : void {
			for each (var network : INetwork in networks) {
				addToNetwork(network);
			}			
		}
		
		public function removeFromNetwork(network : INetwork) : Boolean {
			var index : int = networks.indexOf(network);
			if(index == -1) {
				trace("Edge " + this.ID + " does not belong to network " + network.ID + " when tried to remove.");
				return false;
			}
			else {
				networks.splice(index, 1);
				trace("Edge " + this.ID + " removed from network " + network.ID + ".");
				return true;	
			}
		}

		private function setNodeNetworks(networks : Vector.<INetwork>, connectionType : String) : void {
			var nodes : Vector.<INode> = getNodesByType(connectionType);
			for each (var node : INode in nodes) {
				node.networks = networks;
			}
			
			
		}

		public function getNodesByType(connectionType : String) : Vector.<INode> {
			switch(connectionType){
				case ConnectionType.IN:
					return nodesIn;
					break;
				case ConnectionType.OUT:
					return nodesOut;
					break;
				case ConnectionType.INOUT:
					return nodesInOut;
					break;
				case ConnectionType.ALL:
					return nodesIn.concat(nodesOut, nodesInOut);
					break;
				default:
					return null;
			}
		}

		public function findNetworkWithSmallestID(connectionType : String) : INetwork {
			var nodes : Vector.<INode> = getNodesByType(connectionType);
			//Choose one of the networks
			var networkWithSmallestID : INetwork = nodes[0].networks[0];
			//Try to find a smaller ID
			for each (var node : INode in nodes) {
				for each (var network : INetwork in node.networks) {
					if(network.ID < networkWithSmallestID.ID) {
						networkWithSmallestID = network;
					}
				}
			}
			return networkWithSmallestID;
		}
		
		public function get connectedNetworks() : Vector.<INetwork> {
			var connectedNetworks : Vector.<INetwork> = new Vector.<INetwork>();
			var nodes : Vector.<INode> = getNodesByType(ConnectionType.ALL);
			for each (var node : INode in nodes) {
				for each (var network : INetwork in node.networks) {
					if(connectedNetworks.indexOf(network) == -1) {
						connectedNetworks.push(network);				
					}		
				}
			}
			return connectedNetworks;
		}
		
		public function destroy() : void {
			
		}

		public function sendEffect(effect : IEffect) : void {
		}

		public function enable() : void {
		}

		public function disable() : void {
		}

		public function get weight() : int {
			// TODO: Auto-generated method stub
			return 0;
		}

		public function get nodes() : Vector.<INode> {
			// TODO: Auto-generated method stub
			return null;
		}

		public function set weight(newWeight : int) : void {
		}

		public function get networks() : Vector.<INetwork> {
			return _networks;
		}


		public function get ID() : uint {
			return _ID;
		}

		public function get nodesOut() : Vector.<INode> {
			return _nodesOut;
		}

		public function get nodesIn() : Vector.<INode> {
			return _nodesIn;
		}

		public function set nodesOut(nodesOut : Vector.<INode>) : void {
			if(nodesOut[0] || nodesInOut[0]) { 
			  _nodesOut=nodesOut;
			}
			else trace("Error: Edge has to have at least one 'out from' node.");
		}

		public function set nodesIn(nodesIn : Vector.<INode>) : void {
			if(nodesIn[0] || nodesInOut[0]) { 
				_nodesIn=nodesIn;
			} else trace("Error: Edge has to have at least one 'in to' node.");
		}

		public function get nodesInOut() : Vector.<INode> {
			return _nodesInOut;
		}

		public function set nodesInOut(nodesInOut : Vector.<INode>) : void {
			if(nodesInOut[1] || (nodesIn[0] && nodesOut[0])) { 
				_nodesInOut = nodesInOut;
			} else trace("Error: Edge has to have at least one 'in to' and 'out from' node.");
		}

		public function set networks(networks : Vector.<INetwork>) : void {	
			_networks = networks;
		}

		public function activate() : void {
		}

		public function deactivate() : void {
		}
		
		
		
	}
}
