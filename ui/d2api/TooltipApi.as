package d2api
{
   import d2data.SpellWrapper;
   import d2data.ItemWrapper;
   import d2utils.TooltipRectangle;
   import d2utils.SpellTooltipSettings;
   import d2utils.ItemTooltipSettings;
   
   public class TooltipApi extends Object
   {
      
      public function TooltipApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function setDefaultTooltipUiScript(module:String, ui:String) : void {
      }
      
      public function createTooltip(baseUri:String, containerUri:String, separatorUri:String = null) : Object {
         return null;
      }
      
      public function createTooltipBlock(onAllChunkLoadedCallback:Function, contentGetter:Function) : Object {
         return null;
      }
      
      public function registerTooltipAssoc(targetClass:*, makerName:String) : void {
      }
      
      public function registerTooltipMaker(makerName:String, makerClass:Class, scriptClass:Class = null) : void {
      }
      
      public function createChunkData(name:String, uri:String) : Object {
         return null;
      }
      
      public function place(target:*, point:uint = 6, relativePoint:uint = 0, offset:int = 3, checkSuperposition:Boolean = false, cellId:int = -1, alwaysDisplayed:Boolean = true) : void {
      }
      
      public function placeArrow(target:*) : Object {
         return null;
      }
      
      public function getSpellTooltipInfo(spellWrapper:SpellWrapper, shortcutKey:String = null) : Object {
         return null;
      }
      
      public function getItemTooltipInfo(itemWrapper:ItemWrapper, shortcutKey:String = null) : Object {
         return null;
      }
      
      public function getSpellTooltipCache() : int {
         return 0;
      }
      
      public function resetSpellTooltipCache() : void {
      }
      
      public function createTooltipRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) : TooltipRectangle {
         return null;
      }
      
      public function createSpellSettings() : SpellTooltipSettings {
         return null;
      }
      
      public function createItemSettings() : ItemTooltipSettings {
         return null;
      }
      
      public function adjustTooltipPositions(tooltipNames:Object, sourceName:String, offset:int = 0) : void {
      }
   }
}
