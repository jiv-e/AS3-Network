package fi.validi.network.view.view2d {
	import fi.validi.network.model.IEdge;
	import fi.validi.network.model.model2d.INode2D;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Juho Viitasalo
	 */
	public class EdgeSprite2D extends Sprite {
		private static const IN_COLOR : uint = 0xff0000;
		private static const OUT_COLOR : uint = 0x00ff00;
		private static const IN_THICKNESS : Number = 2;
		private static const OUT_THICKNESS : Number = 2;
		private static const IN_ALPHA : Number = 0.5;
		private static const OUT_ALPHA : Number = 0.5;
		private static const IN : String = "in";
		private static const OUT : String = "out";
		
		private var _fromNode : NodeSprite2D;
		private var _toNode : NodeSprite2D;
		private var _strokeColor:uint = 0x000000;
		private var _activeStrokeColor:uint = 0xFF0000;
		private var _deactiveStrokeColor:uint = 0x000000;
        private var _strokeThickness:int = 1;
        private var _activeStrokeThickness:int = 2;
        private var _deactiveStrokeThickness:int = 1;
		private var _active : Boolean = false;
		
		private static var _edgeCount : Number = 0;
		private var _stroke : Shape;
		
		private var _edgeData : IEdge;
		
		public function EdgeSprite2D(edge : IEdge, allowDublicateEdges : Boolean = false) {
			_edgeData = edge;
			if (stage) draw();
			else addEventListener(Event.ADDED_TO_STAGE, init);
//			if (allowDublicateEdges || fromNode.neighbourNodes.indexOf(toNode)==-1) {
//				_edgeCount++;
//				//trace(edgeCount);
//				_fromNode = fromNode;
//				_toNode = toNode;			
//				draw();
//				//addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
//			}
//			else {
//				trace("Edge already exists. No edge created.");
//			}
			
		}

		private function init(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			draw();
		}

		private function draw() : void {
			var nodesOut : Vector.<INode2D> = Vector.<INode2D>(_edgeData.nodesOut.concat(_edgeData.nodesInOut));
			var nodesIn : Vector.<INode2D> = Vector.<INode2D>(_edgeData.nodesIn.concat(_edgeData.nodesInOut));
			
			if(nodesIn[0] == nodesOut[0] && nodesIn.length == 1 && nodesOut.length == 1) {
				drawStrokeToSelf(nodesIn[0]);
			}
			else {
				var i : uint = 0;
				var j : uint = 0;
				if(nodesIn.length > 1) i++;
				else if(nodesOut.length > 1) j++;
				var inPoint : Point = new Point(nodesIn[i].xProportional*stage.width, nodesIn[i].yProportional*stage.width);
				var outPoint : Point = new Point(nodesOut[j].xProportional*stage.width, nodesOut[j].yProportional*stage.height);
			
			
				var middlePoint : Point = Point.interpolate(outPoint, inPoint, 0.5);

				for each (var nodeOut : INode2D in nodesOut) {
					drawStroke(new Point(nodeOut.xProportional*stage.width,nodeOut.yProportional*stage.width), middlePoint, OUT);
				}
	
				for each (var nodeIn : INode2D in nodesIn) {
					drawStroke(new Point(nodeIn.xProportional*stage.width,nodeIn.yProportional*stage.width), middlePoint, IN);
				}
			}
//			_fromNode.addEdge(this);
//			_toNode.addEdge(this);
//			_fromNode.addNeighbourNode(_toNode);
//			_toNode.addNeighbourNode(_fromNode);
//			drawEdge();
		}

		private function drawStrokeToSelf(node : INode2D) : void {
			_stroke = new Shape();
			_stroke.graphics.lineStyle(IN_THICKNESS, IN_COLOR, IN_ALPHA);
			_stroke.graphics.drawCircle(node.xProportional*stage.width-NodeSprite2D.radius/1.5, node.yProportional*stage.height-NodeSprite2D.radius/1.5, NodeSprite2D.radius/1.5);
			_stroke.graphics.lineStyle(OUT_THICKNESS, OUT_COLOR, OUT_ALPHA);
			_stroke.graphics.drawCircle(node.xProportional*stage.width-NodeSprite2D.radius/1.5, node.yProportional*stage.height-NodeSprite2D.radius/1.5, NodeSprite2D.radius/1.5);
		
		}

		private function drawStroke(p1 : Point, p2 : Point, type : String) : void {
			_stroke = new Shape();
			switch(type){
				case IN:
					_stroke.graphics.lineStyle(IN_THICKNESS, IN_COLOR, IN_ALPHA);
					break;
				case OUT:
					_stroke.graphics.lineStyle(OUT_THICKNESS, OUT_COLOR, OUT_ALPHA);
					break;
				default:
			}

            _stroke.graphics.moveTo(p1.x, p1.y);
			_stroke.graphics.lineTo(p2.x, p2.y);
			
//			if (_fromNode != _toNode) {
//				_stroke.graphics.moveTo(_fromNode.x, _fromNode.y);
//				_stroke.graphics.lineTo(_toNode.x, _toNode.y);
//			}
//			else {
//			    _stroke.graphics.drawCircle(_fromNode.x-_fromNode.radius/1.5, _fromNode.y-_fromNode.radius/1.5, _fromNode.radius/1.5);
//			}
            addChild(_stroke);
		}
		
		private function mouseOverHandler(e:Event):void {
			remove();
		}
		
		public function remove() : void {
//			_fromNode.removeEdge(this);
//			_toNode.removeEdge(this);
//			_fromNode.removeNeighbourNode(_toNode);
//			_toNode.removeNeighbourNode(_fromNode);
			_edgeCount--;
			parent.removeChild(this);
		}
		
		private function drawEdge():void {
//			_stroke = new Shape();
//            _stroke.graphics.lineStyle(_strokeThickness, _strokeColor);
//			if (_fromNode != _toNode) {
//				_stroke.graphics.moveTo(_fromNode.x, _fromNode.y);
//				_stroke.graphics.lineTo(_toNode.x, _toNode.y);
//			}
//			else {
//			    _stroke.graphics.drawCircle(_fromNode.x-_fromNode.radius/1.5, _fromNode.y-_fromNode.radius/1.5, _fromNode.radius/1.5);
//			}
//            addChild(_stroke);
		}
		
		public function lineStyle(thickness : Number, color : uint):void {
			_strokeThickness = thickness;
			_strokeColor = color;
			removeChild(_stroke);
			drawEdge();
		}
		
		public function get active():Boolean { return _active; }
		
		public function set active(value:Boolean):void 
		{	
			if (_active != value) {
				_active = value;
				if (_active) {
					lineStyle(_activeStrokeThickness, _activeStrokeColor);
					if (!_fromNode.active) _fromNode.active = true;
					if (!_toNode.active) _toNode.active = true;
				}
				else {
					lineStyle(_deactiveStrokeThickness, _deactiveStrokeColor);
					if (_fromNode.active) _fromNode.active = false;
					if (_toNode.active) _toNode.active = false;
				}
			}
		}
		
		static public function get edgeCount():Number { return _edgeCount; }
		
	}
}
