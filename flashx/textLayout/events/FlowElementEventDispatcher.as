package flashx.textLayout.events
{
   import flash.events.EventDispatcher;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.TextFlow;

   use namespace tlf_internal;

   public class FlowElementEventDispatcher extends EventDispatcher
   {
         

      public function FlowElementEventDispatcher(element:FlowElement) {
         this._element=element;
         super(null);
      }



      tlf_internal var _listenerCount:int = 0;

      tlf_internal var _element:FlowElement;

      override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false) : void {
         var tf:TextFlow = null;
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
         this._listenerCount++;
         if(this._listenerCount==1)
         {
            tf=this._element.getTextFlow();
            if(tf)
            {
               tf.incInteractiveObjectCount();
            }
         }
         this._element.modelChanged(ModelChange.ELEMENT_MODIFIED,this._element,0,this._element.textLength);
      }

      override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false) : void {
         var tf:TextFlow = null;
         super.removeEventListener(type,listener,useCapture);
         this._listenerCount--;
         if(this._listenerCount==0)
         {
            tf=this._element.getTextFlow();
            if(tf)
            {
               tf.decInteractiveObjectCount();
            }
         }
         this._element.modelChanged(ModelChange.ELEMENT_MODIFIED,this._element,0,this._element.textLength);
      }
   }

}