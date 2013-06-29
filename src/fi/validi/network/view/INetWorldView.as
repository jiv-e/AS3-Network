package fi.validi.network.view {
	import flash.display.DisplayObject;
	import fi.validi.network.model.model2d.NetWorld2D;
	import flash.events.Event;
	import fi.validi.network.model.NetWorldEvent;
	/**
	 * @author jiv
	 */
	public interface INetWorldView {
		function draw(event : Event) : void; 
		function eraseNetworks(event : NetWorldEvent) : void;
		function drawNetworks(event : NetWorldEvent) : void;
		function drawEdge(event : NetWorldEvent) : void;
		function drawNode(event : NetWorldEvent) : void;
		function set data(data : NetWorld2D) : void;
		function get container() : DisplayObject;
	}
}
