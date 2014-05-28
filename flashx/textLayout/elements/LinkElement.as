package flashx.textLayout.elements
{
   import flash.events.IEventDispatcher;
   import flashx.textLayout.tlf_internal;
   import flash.events.Event;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flash.net.*;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.events.FlowElementMouseEventManager;
   import flash.events.MouseEvent;
   
   use namespace tlf_internal;
   
   public final class LinkElement extends SubParagraphGroupElementBase implements IEventDispatcher
   {
      
      public function LinkElement() {
         super();
         this._linkState = LinkState.LINK;
      }
      
      tlf_internal  static const LINK_NORMAL_FORMAT_NAME:String = "linkNormalFormat";
      
      tlf_internal  static const LINK_ACTIVE_FORMAT_NAME:String = "linkActiveFormat";
      
      tlf_internal  static const LINK_HOVER_FORMAT_NAME:String = "linkHoverFormat";
      
      private var _uriString:String;
      
      private var _targetString:String;
      
      private var _linkState:String;
      
      override tlf_internal function get precedence() : uint {
         return 800;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         getEventMirror().addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean {
         if(!hasActiveEventMirror())
         {
            return false;
         }
         return _eventMirror.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean {
         if(!hasActiveEventMirror())
         {
            return false;
         }
         return _eventMirror.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean=false) : void {
         if(hasActiveEventMirror())
         {
            _eventMirror.removeEventListener(param1,param2,param3);
         }
      }
      
      public function willTrigger(param1:String) : Boolean {
         if(!hasActiveEventMirror())
         {
            return false;
         }
         return _eventMirror.willTrigger(param1);
      }
      
      override protected function get abstract() : Boolean {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String {
         return "a";
      }
      
      public function get href() : String {
         return this._uriString;
      }
      
      public function set href(param1:String) : void {
         this._uriString = param1;
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      public function get target() : String {
         return this._targetString;
      }
      
      public function set target(param1:String) : void {
         this._targetString = param1;
         modelChanged(ModelChange.ELEMENT_MODIFIED,this,0,textLength);
      }
      
      public function get linkState() : String {
         return this._linkState;
      }
      
      override public function shallowCopy(param1:int=0, param2:int=-1) : FlowElement {
         if(param2 == -1)
         {
            param2 = textLength;
         }
         var _loc3_:LinkElement = super.shallowCopy(param1,param2) as LinkElement;
         _loc3_.href = this.href;
         _loc3_.target = this.target;
         return _loc3_;
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean {
         var _loc1_:* = 0;
         var _loc2_:LinkElement = null;
         if((parent) && !bindableElement)
         {
            _loc1_ = parent.getChildIndex(this);
            if(textLength == 0)
            {
               parent.replaceChildren(_loc1_,_loc1_ + 1,null);
               return true;
            }
            if(!(_loc1_ == 0) && !hasActiveEventMirror())
            {
               _loc2_ = parent.getChildAt(_loc1_-1) as LinkElement;
               if(!(_loc2_ == null) && !_loc2_.hasActiveEventMirror())
               {
                  if(this.href == _loc2_.href && this.target == _loc2_.target && (equalStylesForMerge(_loc2_)))
                  {
                     parent.removeChildAt(_loc1_);
                     if(numChildren > 0)
                     {
                        _loc2_.replaceChildren(_loc2_.numChildren,_loc2_.numChildren,this.mxmlChildren);
                     }
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      private function computeLinkFormat(param1:String) : ITextLayoutFormat {
         var _loc3_:TextFlow = null;
         var _loc2_:ITextLayoutFormat = getUserStyleWorker(param1) as ITextLayoutFormat;
         if(_loc2_ == null)
         {
            _loc3_ = getTextFlow();
            if(_loc3_)
            {
               _loc2_ = _loc3_.configuration["defaultL" + param1.substr(1)];
            }
         }
         return _loc2_;
      }
      
      tlf_internal function get effectiveLinkElementTextLayoutFormat() : ITextLayoutFormat {
         var _loc1_:ITextLayoutFormat = null;
         if(this._linkState == LinkState.SUPPRESSED)
         {
            return null;
         }
         if(this._linkState == LinkState.ACTIVE)
         {
            _loc1_ = this.computeLinkFormat(LINK_ACTIVE_FORMAT_NAME);
            if(_loc1_)
            {
               return _loc1_;
            }
         }
         else
         {
            if(this._linkState == LinkState.HOVER)
            {
               _loc1_ = this.computeLinkFormat(LINK_HOVER_FORMAT_NAME);
               if(_loc1_)
               {
                  return _loc1_;
               }
            }
         }
         return this.computeLinkFormat(LINK_NORMAL_FORMAT_NAME);
      }
      
      override tlf_internal function get formatForCascade() : ITextLayoutFormat {
         var _loc3_:TextLayoutFormat = null;
         var _loc1_:TextLayoutFormat = TextLayoutFormat(format);
         var _loc2_:ITextLayoutFormat = this.effectiveLinkElementTextLayoutFormat;
         if((_loc2_) || (_loc1_))
         {
            if((_loc2_) && (_loc1_))
            {
               _loc3_ = new TextLayoutFormat(_loc2_);
               if(_loc1_)
               {
                  _loc3_.concatInheritOnly(_loc1_);
               }
               return _loc3_;
            }
            return _loc1_?_loc1_:_loc2_;
         }
         return null;
      }
      
      private function setToState(param1:String) : void {
         var _loc2_:ITextLayoutFormat = null;
         var _loc3_:ITextLayoutFormat = null;
         var _loc4_:TextFlow = null;
         if(this._linkState != param1)
         {
            _loc2_ = this.effectiveLinkElementTextLayoutFormat;
            this._linkState = param1;
            _loc3_ = this.effectiveLinkElementTextLayoutFormat;
            if(!TextLayoutFormat.isEqual(_loc2_,_loc3_))
            {
               formatChanged(true);
               _loc4_ = getTextFlow();
               if((_loc4_) && (_loc4_.flowComposer))
               {
                  _loc4_.flowComposer.updateAllControllers();
               }
            }
         }
      }
      
      tlf_internal function chgLinkState(param1:String) : void {
         if(this._linkState != param1)
         {
            this._linkState = param1;
            formatChanged(false);
         }
      }
      
      tlf_internal function mouseDownHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void {
         param1.setHandCursor(true);
         this.setToState(LinkState.ACTIVE);
         param2.stopImmediatePropagation();
      }
      
      tlf_internal function mouseMoveHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void {
         param1.setHandCursor(true);
         this.setToState(param2.buttonDown?LinkState.ACTIVE:LinkState.HOVER);
      }
      
      tlf_internal function mouseOutHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void {
         param1.setHandCursor(false);
         this.setToState(LinkState.LINK);
      }
      
      tlf_internal function mouseOverHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void {
         param1.setHandCursor(true);
         this.setToState(param2.buttonDown?LinkState.ACTIVE:LinkState.HOVER);
      }
      
      tlf_internal function mouseUpHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void {
         param1.setHandCursor(true);
         this.setToState(LinkState.HOVER);
         param2.stopImmediatePropagation();
      }
      
      tlf_internal function mouseClickHandler(param1:FlowElementMouseEventManager, param2:MouseEvent) : void {
         var _loc3_:URLRequest = null;
         if(this._uriString != null)
         {
            if(this._uriString.length > 6 && this._uriString.substr(0,6) == "event:")
            {
               param1.dispatchFlowElementMouseEvent(this._uriString.substring(6,this._uriString.length),param2);
            }
            else
            {
               _loc3_ = new URLRequest(encodeURI(this._uriString));
               navigateToURL(_loc3_,this.target);
            }
         }
         param2.stopImmediatePropagation();
      }
      
      override tlf_internal function acceptTextBefore() : Boolean {
         return false;
      }
      
      override tlf_internal function acceptTextAfter() : Boolean {
         return false;
      }
      
      override tlf_internal function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void {
         if(param2 == ModelChange.ELEMENT_ADDED)
         {
            param1.incInteractiveObjectCount();
         }
         else
         {
            if(param2 == ModelChange.ELEMENT_REMOVAL)
            {
               param1.decInteractiveObjectCount();
            }
         }
         super.appendElementsForDelayedUpdate(param1,param2);
      }
      
      override tlf_internal function updateForMustUseComposer(param1:TextFlow) : Boolean {
         return true;
      }
   }
}
