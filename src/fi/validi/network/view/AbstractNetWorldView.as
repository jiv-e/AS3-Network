package fi.validi.network.view {
	import fi.validi.network.model.NetWorldEvent;
	import flash.events.Event;
	import fi.validi.network.model.NetWorld;
	import flash.display.Sprite;

	/**
	 * @author Juho Viitasalo
	 */
	public class AbstractNetWorldView extends Sprite {
		protected var _data : NetWorld;
		
		public function AbstractNetWorldView(data : NetWorld) {
			_data = data;
			_data.addEventListener(Event.CHANGE, draw);
			_data.addEventListener(NetWorldEvent.NODE_CREATED, draw);
			_data.addEventListener(NetWorldEvent.EDGE_CREATED, draw);
			_data.addEventListener(NetWorldEvent.NETWORKS_CHANGED, draw);
		}

		protected function draw(event : Event = null) : void {
		}
		
		public function set data(newData : NetWorld) : void {
			_data = newData;
		}
	}
}
