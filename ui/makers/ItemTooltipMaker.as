package makers
{
   import d2api.AveragePricesApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.SystemApi;
   import d2hooks.*;
   import blocks.TextTooltipBlock;
   import blocks.ItemTooltipBlock;
   import blocks.EffectTooltipBlock;
   import blocks.ConditionTooltipBlock;
   import blocks.DescriptionTooltipBlock;
   
   public class ItemTooltipMaker extends Object
   {
      
      public function ItemTooltipMaker() {
         super();
      }
      
      private var _param:paramClass;
      
      public function createTooltip(data:*, param:Object) : Object {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
class paramClass extends Object
{
   
   function paramClass() {
      super();
   }
   
   public var header:Boolean = true;
   
   public var effects:Boolean = true;
   
   public var description:Boolean = true;
   
   public var noBg:Boolean = false;
   
   public var CC_EC:Boolean = true;
   
   public var conditions:Boolean = true;
   
   public var targetConditions:Boolean = true;
   
   public var length:int = 409;
   
   public var averagePrice:Boolean = true;
   
   public var equipped:Boolean = false;
}
