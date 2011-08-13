package fi.validi.network.model.model2d {
	import fi.validi.network.model.INode;

	/**
	 * @author Juho Viitasalo
	 */
	public interface INode2D extends INode {
		function get xProportional() : Number;
		function get yProportional() : Number;
		function set xProportional(xProportional : Number) : void;
		function set yProportional(yProportional : Number) : void;
	}
}
