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
         

      public function TextAccImpl(textCont:DisplayObject, textFlow:TextFlow) {
         super();
         this.textContainer=textCont;
         this.textFlow=textFlow;
         stub=false;
         if(textCont.accessibilityProperties==null)
         {
            textCont.accessibilityProperties=new AccessibilityProperties();
         }
         textFlow.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE,this.eventHandler);
      }

      protected static const STATE_SYSTEM_NORMAL:uint = 0;

      protected static const STATE_SYSTEM_READONLY:uint = 64;

      protected static const STATE_SYSTEM_INVISIBLE:uint = 32768;

      protected static const ROLE_SYSTEM_STATICTEXT:uint = 41;

      protected static const ROLE_SYSTEM_TEXT:uint = 42;

      protected static const EVENT_OBJECT_NAMECHANGE:uint = 32780;

      protected static const EVENT_OBJECT_VALUECHANGE:uint = 32782;

      private static function exportToString(source:TextFlow) : String {
         var p:ParagraphElement = null;
         var temparray:Array = null;
         var leaf:FlowLeafElement = source.getFirstLeaf();
         var rslt:String = "";
         var curString:String = "";
         var discretionaryHyphen:String = String.fromCharCode(173);
         loop0:
         while(leaf)
         {
            p=leaf.getParagraph();
            do
            {
               curString=leaf.text;
               temparray=curString.split(discretionaryHyphen);
               curString=temparray.join("");
               rslt=rslt+curString;
               leaf=leaf.getNextLeaf(p);
               if(!leaf)
               {
                  rslt=rslt+"\n";
                  leaf=p.getLastLeaf().getNextLeaf();
                  continue loop0;
               }
            }
            while(true);
         }
         return rslt;
      }

      protected var textContainer:DisplayObject;

      protected var textFlow:TextFlow;

      public function detachListeners() : void {
         this.textFlow.removeEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE,this.eventHandler);
      }

      override public function get_accRole(childID:uint) : uint {
         var iManager:ISelectionManager = this.textFlow.interactionManager;
         if(iManager==null)
         {
            return ROLE_SYSTEM_STATICTEXT;
         }
         return ROLE_SYSTEM_TEXT;
      }

      override public function get_accState(childID:uint) : uint {
         var iManager:ISelectionManager = this.textFlow.interactionManager;
         if(iManager==null)
         {
            return STATE_SYSTEM_READONLY;
         }
         if(iManager.editingMode==EditingMode.READ_WRITE)
         {
            return STATE_SYSTEM_NORMAL;
         }
         return STATE_SYSTEM_READONLY;
      }

      override public function get_accName(childID:uint) : String {
         switch(this.get_accRole(childID))
         {
            case ROLE_SYSTEM_STATICTEXT:
               return exportToString(this.textFlow);
               break;
            case ROLE_SYSTEM_TEXT:
         }
         return null;
      }

      override public function get_accValue(childID:uint) : String {
         switch(this.get_accRole(childID))
         {
            case ROLE_SYSTEM_TEXT:
               return exportToString(this.textFlow);
               break;
            case ROLE_SYSTEM_STATICTEXT:
         }
         return null;
      }

      protected function eventHandler(event:Event) : void {
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
         var selMgr:ISelectionManager = this.textFlow.interactionManager;
         var selIndex:int = -1;
         if((selMgr)&&(!(selMgr.editingMode==EditingMode.READ_ONLY)))
         {
            selIndex=selMgr.activePosition;
         }
         return selIndex;
      }

      public function get selectionAnchorIndex() : int {
         var selMgr:ISelectionManager = this.textFlow.interactionManager;
         var selIndex:int = -1;
         if((selMgr)&&(!(selMgr.editingMode==EditingMode.READ_ONLY)))
         {
            selIndex=selMgr.anchorPosition;
         }
         return selIndex;
      }

      public function get searchText() : String {
         return GlobalSettings.enableSearch?this.textFlow.getText():null;
      }
   }

}