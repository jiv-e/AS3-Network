package fi.validi.network.model.model2d {
	import fi.validi.network.model.INetWorld;
	import fi.validi.network.model.NetWorldEvent;
	import fi.validi.network.model.AbstractNode;
	import fi.validi.network.model.INetwork;

	/**
	 * @author Juho Viitasalo
	 */
	public class Node2D extends AbstractNode implements INode2D {

		
		private var _xProportional : Number;
		private var _yProportional : Number;
		
		public function Node2D(xProportional : Number, yProportional : Number, toNetWorld : INetWorld, toNetworks : Vector.<INetwork>) {
			super(toNetWorld, toNetworks);
			_xProportional = xProportional;
			_yProportional = yProportional;
			
//			if(connectToEdge) {
//				if(connectionType) {
//					connect(connectToEdge, connectionType);					
//				}
//				else {
//					connect(connectToEdge, ConnectionType.INOUT);
//				}
//				var s : String = "";
//				for each (var network : INetwork in _networks) {
//					s += network.ID + ", ";
//				}
//				trace("Node created and connected to networks: " + s);
//			}
//			else {
//				_networks.push(new Network());
//				_networks[0].addNode(this);
//				trace("Node created to new network: " + _networks[0].ID);
//			}
			
			
			
		}



		public function get xProportional() : Number {
			return _xProportional;
		}

		public function get yProportional() : Number {
			return _yProportional;
		}

		public function set yProportional(yProportional : Number) : void {
			_yProportional = yProportional;
		}

		public function set xProportional(xProportional : Number) : void {
			_xProportional = xProportional;
		}		

		
	}
}
