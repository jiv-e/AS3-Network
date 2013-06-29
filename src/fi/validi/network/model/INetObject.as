package fi.validi.network.model {
	import flash.events.IEventDispatcher;
	/**
	 * @author Juho Viitasalo
	 */
	public interface INetObject extends IEventDispatcher{
		function destroy() : void;
		function sendEffect(effect : IEffect) : void;
		function addToNetwork(network : INetwork) : void; 
		function addToNetworks(networks : Vector.<INetwork>) : void; 
		function enable() : void;
		function disable() : void;
		function get networks() : Vector.<INetwork>;
		function set networks(networks : Vector.<INetwork>) : void;
		function get ID() : uint;
		function activate() : void;
		function deactivate() : void;
	}
	
}
