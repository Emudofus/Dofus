package com.ankamagames.jerakine.utils.system
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.text.TextField;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.filters.DropShadowFilter;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.Callback;
   
   public class SystemPopupUI extends Sprite
   {
      
      public function SystemPopupUI(param1:String) {
         super();
         if(_popupRef[param1])
         {
            throw new ArgumentError("A SystemPopupUI called \'" + param1 + "\' already exist, call destroy() before.");
         }
         else
         {
            _popupRef[param1] = this;
            this._id = param1;
            return;
         }
      }
      
      private static const _popupRef:Dictionary = new Dictionary();
      
      public static function get(param1:String) : SystemPopupUI {
         return _popupRef[param1];
      }
      
      private var _title:String;
      
      private var _content:String;
      
      private var _modal:Boolean;
      
      private var _centerContent:Boolean = true;
      
      private var _buttons:Array;
      
      private var _mainContainer:Sprite;
      
      private var _titleTf:TextField;
      
      private var _contentTf:TextField;
      
      private var _id:String;
      
      private var _style_bg_color:uint = 16777215;
      
      private var _style_font_color:uint = 5592405;
      
      private var _style_title_color:uint = 14540253;
      
      private var _style_border_color:uint = 11184810;
      
      private var _window_width:uint = 900;
      
      private var _callBacks:Dictionary;
      
      public function destroy() : void {
         if(parent)
         {
            parent.removeChild(this);
            this.buildUI(true);
            delete _popupRef[[this._id]];
         }
      }
      
      public function show() : void {
         StageShareManager.rootContainer.addChild(this);
      }
      
      public function get modal() : Boolean {
         return this._modal;
      }
      
      public function set modal(param1:Boolean) : void {
         if(param1 != this._modal)
         {
            this._modal = param1;
            graphics.clear();
            if(param1)
            {
               graphics.beginFill(16777215,0.7);
               graphics.drawRect(0,0,StageShareManager.startWidth,StageShareManager.startHeight);
            }
         }
      }
      
      public function get buttons() : Array {
         return this._buttons;
      }
      
      public function set buttons(param1:Array) : void {
         this._buttons = param1;
         this.buildUI();
      }
      
      public function get content() : String {
         return this._content;
      }
      
      public function set content(param1:String) : void {
         this._content = param1;
         this.buildUI();
      }
      
      public function get title() : String {
         return this._title;
      }
      
      public function set title(param1:String) : void {
         this._title = param1;
         this.buildUI();
      }
      
      override public function set width(param1:Number) : void {
         this._window_width = param1;
         this.buildUI();
      }
      
      public function set centerContent(param1:Boolean) : void {
         this._centerContent = param1;
         this.buildUI();
      }
      
      public function get centerContent() : Boolean {
         return this._centerContent;
      }
      
      private function buildUI(param1:Boolean=false) : void {
         var _loc3_:* = undefined;
         var _loc4_:Sprite = null;
         var _loc5_:Object = null;
         var _loc6_:DisplayObject = null;
         if(!this._title || !this._content)
         {
            return;
         }
         while(numChildren)
         {
            removeChildAt(0);
         }
         if(this._callBacks)
         {
            for (_loc3_ in this._callBacks)
            {
               Sprite(_loc3_).removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnMouseOver);
               Sprite(_loc3_).removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnMouseOut);
               Sprite(_loc3_).removeEventListener(MouseEvent.CLICK,this.onBtnClick);
            }
         }
         this._callBacks = new Dictionary();
         if(param1)
         {
            return;
         }
         this._mainContainer = new Sprite();
         addChild(this._mainContainer);
         this._titleTf = new TextField();
         this._titleTf.selectable = false;
         this._titleTf.autoSize = TextFieldAutoSize.LEFT;
         this._titleTf.height = 20;
         var _loc2_:TextFormat = new TextFormat("Verdana",16,this._style_font_color,true);
         this._titleTf.defaultTextFormat = _loc2_;
         this._titleTf.text = this._title;
         this._mainContainer.addChild(this._titleTf);
         this._contentTf = new TextField();
         this._contentTf.width = this._window_width;
         _loc2_ = new TextFormat("Verdana",14,this._style_font_color,null,null,null,null,null,this._centerContent?TextFormatAlign.CENTER:TextFormatAlign.LEFT);
         this._contentTf.defaultTextFormat = _loc2_;
         this._contentTf.wordWrap = true;
         this._contentTf.multiline = true;
         this._contentTf.text = this._content;
         this._contentTf.height = (this._content.split("\n").length + 1) * 23;
         this._contentTf.y = 30;
         this._mainContainer.addChild(this._contentTf);
         if((this._buttons) && (this._buttons.length))
         {
            _loc4_ = new Sprite();
            for each (_loc5_ in this._buttons)
            {
               _loc6_ = this.createButton(_loc5_.label);
               this._callBacks[_loc6_] = _loc5_.callback;
               _loc6_.x = _loc4_.width?_loc4_.width + 10:0;
               _loc4_.addChild(_loc6_);
            }
            _loc4_.y = this._contentTf.y + this._contentTf.height + 10;
            _loc4_.x = (this._mainContainer.width - _loc4_.width) / 2;
            this._mainContainer.addChild(_loc4_);
         }
         this._mainContainer.graphics.lineStyle(1,this._style_border_color);
         this._mainContainer.graphics.beginFill(this._style_bg_color);
         this._mainContainer.graphics.drawRect(-2,-2,this._window_width + 4,this._mainContainer.height + 10);
         this._mainContainer.graphics.beginFill(this._style_title_color);
         this._mainContainer.graphics.drawRect(-2,-2,this._window_width + 4,25);
         this._mainContainer.x = (StageShareManager.startWidth - this._mainContainer.width) / 2;
         this._mainContainer.y = (StageShareManager.startHeight - this._mainContainer.height) / 2;
         this._mainContainer.filters = [new DropShadowFilter(1,45,0,0.5,10,10,1,3)];
      }
      
      private function createButton(param1:String) : DisplayObject {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:TextField = new TextField();
         var _loc4_:TextFormat = new TextFormat("Verdana",12,this._style_font_color,true,null,null,null,null,TextFormatAlign.CENTER);
         _loc3_.defaultTextFormat = _loc4_;
         _loc3_.text = param1;
         _loc3_.height = 20;
         _loc3_.width = _loc3_.textWidth < 50?50:_loc3_.textWidth + 10;
         _loc3_.selectable = false;
         _loc3_.mouseEnabled = false;
         _loc2_.addChild(_loc3_);
         _loc2_.graphics.lineStyle(1,this._style_border_color + 1118481);
         _loc2_.graphics.beginFill(this._style_title_color + 1118481);
         _loc2_.graphics.drawRoundRect(-2,-2,_loc3_.width + 5,25,2,2);
         _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onBtnMouseOver);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onBtnMouseOut);
         _loc2_.addEventListener(MouseEvent.CLICK,this.onBtnClick);
         _loc2_.buttonMode = true;
         return _loc2_;
      }
      
      private function onBtnMouseOver(param1:Event) : void {
         var _loc2_:Sprite = param1.target as Sprite;
         _loc2_.graphics.lineStyle(1,this._style_border_color);
         _loc2_.graphics.beginFill(this._style_title_color);
         _loc2_.graphics.drawRoundRect(-2,-2,_loc2_.width-1,25,2,2);
      }
      
      private function onBtnMouseOut(param1:Event) : void {
         var _loc2_:Sprite = param1.target as Sprite;
         _loc2_.graphics.lineStyle(1,this._style_border_color + 1118481);
         _loc2_.graphics.beginFill(this._style_title_color + 1118481);
         _loc2_.graphics.drawRoundRect(-2,-2,_loc2_.width-1,25,2,2);
      }
      
      private function onBtnClick(param1:Event) : void {
         if(this._callBacks[param1.target] is Function)
         {
            this._callBacks[param1.target]();
         }
         else
         {
            if(this._callBacks[param1.target] is Callback)
            {
               Callback(this._callBacks[param1.target]).exec();
            }
         }
         this.destroy();
      }
   }
}
