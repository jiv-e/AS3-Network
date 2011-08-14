package fi.validi.network.model {
	import flash.events.IEventDispatcher;
	/**
	 * @author Juho Viitasalo
	 */
	public interface INetObject extends IEventDispatcher{
		function destroy() : void;
		function sendEffect(effect : IEffect) : void;
		function enable() : void;
		function disable() : void;
		function get ID() : uint;
	}
	
}
