package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import flash.display.Shape;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.filters.DropShadowFilter;
   import flash.text.TextFieldAutoSize;


   public class DebugToolTip extends Sprite
   {
         

      public function DebugToolTip() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this._textformat=new TextFormat();
            this._textformat.size=15;
            this._textformat.color=0;
            mouseEnabled=false;
            mouseChildren=false;
            this._shape=new Shape();
            f=new DropShadowFilter(0,45,4473924,0.5,4,4,1,1);
            filters=[f];
            addChild(this._shape);
            this._textfield=new TextField();
            this._textfield.defaultTextFormat=this._textformat;
            this._textfield.autoSize=TextFieldAutoSize.LEFT;
            addChild(this._textfield);
            return;
         }
      }

      private static var _self:DebugToolTip;

      public static function getInstance() : DebugToolTip {
         if(!_self)
         {
            _self=new DebugToolTip();
         }
         return _self;
      }

      private var _shape:Shape;

      private var _textfield:TextField;

      private var _textformat:TextFormat;

      private var _minWidth:Number = 300;

      private var _minHeight:Number = 100;

      private var _defautX:Number = 1280;

      private var _defautY:Number = 880;

      public function setPosition(pX:Number, pY:Number) : void {
         x=pX;
         y=pY;
      }

      public function set text(s:String) : void {
         this._textfield.text=s;
         this._shape.x=this._textfield.x-4;
         this._shape.y=this._textfield.y-4;
         var pw:Number = this._minWidth<this._textfield.textWidth+8?this._textfield.textWidth+8:this._minWidth;
         var ph:Number = this._minHeight<this._textfield.textHeight+8?this._textfield.textHeight+8:this._minHeight;
         this._shape.graphics.clear();
         this._shape.graphics.beginFill(16777215,0.7);
         this._shape.graphics.drawRect(0,0,pw,ph);
         this.setPosition(this._defautX-pw,this._defautY-ph);
      }
   }

}