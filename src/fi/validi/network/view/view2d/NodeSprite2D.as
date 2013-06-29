package fi.validi.network.view.view2d {
	import fi.validi.network.model.INetwork;
	import fi.validi.network.model.NetWorldEvent;
	import fi.validi.network.model.model2d.INode2D;
	import fi.validi.network.view.INetWorldView;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;

	/**
	 * @author Juho Viitasalo
	 */
	public class NodeSprite2D extends Sprite {
		private var _originalFillColor:uint = 0xFFCC00;
		private var _fillColor:uint = 0xFFCC00;
        private var _mouseOverColor:uint = 0xFF0000;
        private var _strokeColor:uint = 0x000000;
        private var _strokeThickness:int = 1;
		private var _fill:Shape;
		private var _stroke:Shape;
		
		private static var _radius : Number = 5;
		private var _upscale : Number = 1.2;
		private var _mouseOutDuration : Number = 0.5;
		private var _mouseOverDuration : Number = 0.1;
		
		private var _colorTransform : ColorTransform;
		
		private var _active : Boolean = false;
		
		private var _nodeData : INode2D;
		
		private var textField : TextField;
		private var _withLabel : Boolean;
		private var _worldView : INetWorldView;
		
		public function NodeSprite2D(node : INode2D, worldView : INetWorldView, withLabel : Boolean = false) {
			_worldView = worldView;
			_nodeData = node;
			_withLabel = withLabel;
			_nodeData.addEventListener(NetWorldEvent.ACTIVATED, activatedListener);
			_nodeData.addEventListener(NetWorldEvent.DEACTIVATED, deactivateListener);
			if (stage) draw();
			else addEventListener(Event.ADDED_TO_STAGE, init);			
		}

		private function activatedListener(event : NetWorldEvent) : void {
			activate();
		}

		private function deactivateListener(event : NetWorldEvent) : void {
			deactivate();
		}

		private function init(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			draw();
		}

		private function draw() : void {
			this.x = _nodeData.xProportional*(_worldView.container.width-2*_radius)+_radius;
			this.y = _nodeData.yProportional*(_worldView.container.height-2*_radius)+_radius;
			drawCircleFill();
			drawCircleStroke();
			_colorTransform = new ColorTransform();
			addListeners();
			if(_withLabel) {
				addText(String(_nodeData.ID));
			}
		}
		
		private function addListeners():void {
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			removeText();
			deactivateNetworks();
		}

		private function deactivateNetworks() : void {
			for each (var network : INetwork in _nodeData.networks) {
				network.deactivate();				
			}
		}

		
		private function mouseOverHandler(e:MouseEvent):void {
			addText(_nodeData.networkIDs.join());
			activateNetworks();
		}

		private function activateNetworks() : void {
			for each (var network : INetwork in _nodeData.networks) {
				network.activate();				
			}
		}
		
		private function drawCircleFill():void {
            _fill = new Shape();
            _fill.graphics.beginFill(_originalFillColor);
            _fill.graphics.drawCircle(0, 0, _radius);
            _fill.graphics.endFill();
            addChild(_fill);
        }
		
		private function drawCircleStroke():void {
            _stroke = new Shape();
            _stroke.graphics.lineStyle(_strokeThickness, _strokeColor);
            _stroke.graphics.drawCircle(0, 0, _radius);
            addChild(_stroke);
        }
		
		public function get fillColor():uint { return _fillColor; }
		
		public function set fillColor(value:uint):void 
		{
			_fillColor = value;
			_colorTransform.color = _fillColor;
			_fill.transform.colorTransform = _colorTransform;
		}
		
		public static function get radius():Number { return _radius; }
		
		public static function set radius(value:Number):void {
			_radius = value;
		}
		
		public function get active():Boolean { return _active; }
		
		public function set active(value:Boolean):void 
		{
			if (_active != value) {
				_active = value;
				if (_active) activate();
				else deactivate();
			}
		}
		
		

//		
//		public function addEdge(edge : EdgeSprite):void {
//			_edges.push(edge);
//		}
//		
//		public function removeEdge(edge : EdgeSprite):void {
//			_edges.splice(_edges.indexOf(edge),1);
//		}
//		
//		public function addNeighbourNode(node : NodeSprite) : void {
//			_neighbourNodes.push(node);
//		}
//		
//		public function removeNeighbourNode(node : NodeSprite) : void {
//			_neighbourNodes.splice(_neighbourNodes.indexOf(node), 1);
//		}
		
		private function activate() : void {
			//TweenLite.to(this, _mouseOverDuration, { scaleX:_upscale, scaleY:_upscale, hexColors: { currentFillColor: _mouseOverColor }} );
			fillColor = _mouseOverColor;
//			for (var i : int = 0; i < _edges.length; i++) {
//				_edges[i].active = true;
//			}
		}
		
		private function deactivate() : void {
			//TweenLite.to(this, _mouseOutDuration, { scaleX:1, scaleY:1, hexColors: { currentFillColor: _fillColor }} );
			fillColor = _originalFillColor;
//			for (var i : int = 0; i < _edges.length; i++) {
//				_edges[i].active = false;
//			}
		}
		
//		public function isNeighbour(node : NodeSprite) : Boolean {
//			return this.neighbourNodes.indexOf(node) != -1;
//		}
		
		public function remove() :void {
//			while (_edges.length != 0) {
//				_edges.pop().remove;
//			}
//			_nodeCount--;
//			parent.removeChild(this);
		}
		
		private function addText(string : String) : void {
			textField = new TextField();
			textField.text = string;
			textField.scaleX = 2;
			textField.scaleY = 2;
			addChild(textField);
		}
		
		private function removeText() : void {
			removeChild(textField);
		}
		
	}
}
