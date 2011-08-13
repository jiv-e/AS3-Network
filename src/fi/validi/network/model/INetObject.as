package fi.validi.network.model {
	/**
	 * @author Juho Viitasalo
	 */
	public interface INetObject {
		function destroy() : void;
		function sendEffect(effect : IEffect) : void;
		function enable() : void;
		function disable() : void;
		function get ID() : uint;
	}
	
}
