package fi.validi.network.model {
	/**
	 * @author Juho Viitasalo
	 */
	public interface IEdge extends INetObject {
		function get weight() : int;
		function set weight(newWeight : int) : void;
		function get nodes() : Vector.<INode>;
		function get nodesOut() : Vector.<INode>;
		function get nodesIn() : Vector.<INode>;
		function get nodesInOut() : Vector.<INode>;
	}
}
