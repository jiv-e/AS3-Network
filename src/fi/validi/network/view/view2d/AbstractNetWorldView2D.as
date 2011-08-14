package fi.validi.network.view.view2d {
	import fi.validi.network.model.NetWorldEvent;
	import fi.validi.network.model.model2d.NetWorld2D;
	import flash.events.Event;
	import fi.validi.network.model.NetWorld;
	import flash.display.Sprite;

	/**
	 * @author Juho Viitasalo
	 */
	public class AbstractNetWorldView2D extends Sprite {
		protected var _data : NetWorld2D;
		
		
		public function AbstractNetWorldView2D(data : NetWorld2D) {
			_data = data;
			_data.addEventListener(Event.CHANGE, draw);
			_data.addEventListener(NetWorldEvent.NODE_CREATED, drawNode);
			_data.addEventListener(NetWorldEvent.EDGE_CREATED, drawEdge);
			_data.addEventListener(NetWorldEvent.NETWORK_CREATED, drawNetworks);
			_data.addEventListener(NetWorldEvent.NETWORK_DESTROYED, eraseNetworks);
			_data.addEventListener(NetWorldEvent.NETWORKS_CHANGED, drawNetworks);
		}

		public function draw(event : Event) : void {
		}

		public function eraseNetworks(event : NetWorldEvent) : void {
		}

		public function drawNetworks(event : NetWorldEvent) : void {
		}

		public function drawEdge(event : NetWorldEvent) : void {
		}

		public function drawNode(event : NetWorldEvent) : void {
		}
		
		public function set data(data : NetWorld2D) : void {
			_data = data;
		}

	}
}
