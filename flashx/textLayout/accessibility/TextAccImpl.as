package flashx.textLayout.accessibility
{
   import flash.accessibility.AccessibilityImplementation;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flash.display.DisplayObject;
   import flashx.textLayout.events.CompositionCompleteEvent;
   import flashx.textLayout.edit.ISelectionManager;
   import flashx.textLayout.edit.EditingMode;
   import flash.events.Event;
   import flash.accessibility.Accessibility;
   import flashx.textLayout.elements.GlobalSettings;
   import flash.accessibility.AccessibilityProperties;
   
   public class TextAccImpl extends AccessibilityImplementation
   {
      
      public function TextAccImpl(param1:DisplayObject, param2:TextFlow) {
         super();
         this.textContainer = param1;
         this.textFlow = param2;
         stub = false;
         if(param1.accessibilityProperties == null)
         {
            param1.accessibilityProperties = new AccessibilityProperties();
         }
         param2.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE,this.eventHandler);
      }
      
      protected static const STATE_SYSTEM_NORMAL:uint = 0;
      
      protected static const STATE_SYSTEM_READONLY:uint = 64;
      
      protected static const STATE_SYSTEM_INVISIBLE:uint = 32768;
      
      protected static const ROLE_SYSTEM_STATICTEXT:uint = 41;
      
      protected static const ROLE_SYSTEM_TEXT:uint = 42;
      
      protected static const EVENT_OBJECT_NAMECHANGE:uint = 32780;
      
      protected static const EVENT_OBJECT_VALUECHANGE:uint = 32782;
      
      private static function exportToString(param1:TextFlow) : String {
         var _loc6_:ParagraphElement = null;
         var _loc7_:Array = null;
         var _loc2_:FlowLeafElement = param1.getFirstLeaf();
         var _loc3_:* = "";
         var _loc4_:* = "";
         var _loc5_:String = String.fromCharCode(173);
         while(_loc2_)
         {
            _loc6_ = _loc2_.getParagraph();
            do
            {
                  _loc4_ = _loc2_.text;
                  _loc7_ = _loc4_.split(_loc5_);
                  _loc4_ = _loc7_.join("");
                  _loc3_ = _loc3_ + _loc4_;
                  _loc2_ = _loc2_.getNextLeaf(_loc6_);
               }while(_loc2_);
               
               _loc3_ = _loc3_ + "\n";
               _loc2_ = _loc6_.getLastLeaf().getNextLeaf();
            }
            return _loc3_;
         }
         
         protected var textContainer:DisplayObject;
         
         protected var textFlow:TextFlow;
         
         public function detachListeners() : void {
            this.textFlow.removeEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE,this.eventHandler);
         }
         
         override public function get_accRole(param1:uint) : uint {
            var _loc2_:ISelectionManager = this.textFlow.interactionManager;
            if(_loc2_ == null)
            {
               return ROLE_SYSTEM_STATICTEXT;
            }
            return ROLE_SYSTEM_TEXT;
         }
         
         override public function get_accState(param1:uint) : uint {
            var _loc2_:ISelectionManager = this.textFlow.interactionManager;
            if(_loc2_ == null)
            {
               return STATE_SYSTEM_READONLY;
            }
            if(_loc2_.editingMode == EditingMode.READ_WRITE)
            {
               return STATE_SYSTEM_NORMAL;
            }
            return STATE_SYSTEM_READONLY;
         }
         
         override public function get_accName(param1:uint) : String {
            switch(this.get_accRole(param1))
            {
               case ROLE_SYSTEM_STATICTEXT:
                  return exportToString(this.textFlow);
               case ROLE_SYSTEM_TEXT:
               default:
                  return null;
            }
         }
         
         override public function get_accValue(param1:uint) : String {
            switch(this.get_accRole(param1))
            {
               case ROLE_SYSTEM_TEXT:
                  return exportToString(this.textFlow);
               case ROLE_SYSTEM_STATICTEXT:
               default:
                  return null;
            }
         }
         
         protected function eventHandler(param1:Event) : void {
            var event:Event = param1;
            switch(event.type)
            {
               case CompositionCompleteEvent.COMPOSITION_COMPLETE:
                  try
                  {
                     Accessibility.sendEvent(this.textContainer,0,EVENT_OBJECT_NAMECHANGE);
                     Accessibility.sendEvent(this.textContainer,0,EVENT_OBJECT_VALUECHANGE);
                     Accessibility.updateProperties();
                  }
                  catch(e_err:Error)
                  {
                  }
                  break;
            }
         }
         
         public function get selectionActiveIndex() : int {
            var _loc1_:ISelectionManager = this.textFlow.interactionManager;
            var _loc2_:* = -1;
            if((_loc1_) && !(_loc1_.editingMode == EditingMode.READ_ONLY))
            {
               _loc2_ = _loc1_.activePosition;
            }
            return _loc2_;
         }
         
         public function get selectionAnchorIndex() : int {
            var _loc1_:ISelectionManager = this.textFlow.interactionManager;
            var _loc2_:* = -1;
            if((_loc1_) && !(_loc1_.editingMode == EditingMode.READ_ONLY))
            {
               _loc2_ = _loc1_.anchorPosition;
            }
            return _loc2_;
         }
         
         public function get searchText() : String {
            return GlobalSettings.enableSearch?this.textFlow.getText():null;
         }
      }
   }
