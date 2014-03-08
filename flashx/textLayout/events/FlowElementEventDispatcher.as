package flashx.textLayout.events
{
   import flash.events.EventDispatcher;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.TextFlow;
   
   use namespace tlf_internal;
   
   public class FlowElementEventDispatcher extends EventDispatcher
   {
      
      public function FlowElementEventDispatcher(param1:FlowElement) {
         this._element = param1;
         super(null);
      }
      
      tlf_internal var _listenerCount:int = 0;
      
      tlf_internal var _element:FlowElement;
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         var _loc6_:TextFlow = null;
         super.addEventListener(param1,param2,param3,param4,param5);
         this._listenerCount++;
         if(this._listenerCount == 1)
         {
            _loc6_ = this._element.getTextFlow();
            if(_loc6_)
            {
               _loc6_.incInteractiveObjectCount();
            }
         }
         this._element.modelChanged(ModelChange.ELEMENT_MODIFIED,this._element,0,this._element.textLength);
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean=false) : void {
         var _loc4_:TextFlow = null;
         super.removeEventListener(param1,param2,param3);
         this._listenerCount--;
         if(this._listenerCount == 0)
         {
            _loc4_ = this._element.getTextFlow();
            if(_loc4_)
            {
               _loc4_.decInteractiveObjectCount();
            }
         }
         this._element.modelChanged(ModelChange.ELEMENT_MODIFIED,this._element,0,this._element.textLength);
      }
   }
}
