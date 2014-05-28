package flashx.textLayout.elements
{
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ContainerFormattedElement extends ParagraphFormattedElement
   {
      
      public function ContainerFormattedElement() {
         super();
      }
      
      public function get flowComposer() : IFlowComposer {
         return null;
      }
      
      override tlf_internal function formatChanged(param1:Boolean=true) : void {
         var _loc2_:* = 0;
         super.formatChanged(param1);
         if(this.flowComposer)
         {
            _loc2_ = 0;
            while(_loc2_ < this.flowComposer.numControllers)
            {
               this.flowComposer.getControllerAt(_loc2_).formatChanged();
               _loc2_++;
            }
         }
      }
      
      tlf_internal function preCompose() : void {
      }
      
      override tlf_internal function normalizeRange(param1:uint, param2:uint) : void {
         var _loc3_:ParagraphElement = null;
         super.normalizeRange(param1,param2);
         if(this.numChildren == 0)
         {
            _loc3_ = new ParagraphElement();
            if(this.canOwnFlowElement(_loc3_))
            {
               _loc3_.replaceChildren(0,0,new SpanElement());
               replaceChildren(0,0,_loc3_);
               _loc3_.normalizeRange(0,_loc3_.textLength);
            }
         }
      }
   }
}
