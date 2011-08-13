package fi.validi.network.model {
	/**
	 * @author Juho Viitasalo
	 */
	public interface INode extends INetObject {
		//Remove all connected edges
		function detatch() : void;		
//		function connect(edge : IEdge, connectionType : String) : void;
		function connectInEdge(edge : IEdge) : void;
		function connectOutEdge(edge : IEdge) : void;
		function get inEdges() : Vector.<IEdge>;
		function get outEdges() : Vector.<IEdge>;
		function get networks() : Vector.<INetwork>;
		function set networks(networks : Vector.<INetwork>) : void;
		function get networkIDs() : Vector.<uint>;
		function isNeighbour(node : INode) : Boolean;
	}
}
