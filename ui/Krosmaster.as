package 
{
   import flash.display.Sprite;
   import d2hooks.OpenKrosmaster;
   import d2data.OptionalFeature;
   import d2enums.StrataEnum;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.ConfigApi;
   import d2api.SystemApi;
   
   public class Krosmaster extends Sprite
   {
      
      public function Krosmaster() {
         super();
      }
      
      public function main() : void {
         if(this.sysApi.isStreaming())
         {
            return;
         }
         this.sysApi.addHook(OpenKrosmaster,this.openArena);
      }
      
      public function openArena() : void {
         var feature:OptionalFeature = this.dataApi.getOptionalFeatureByKeyword("game.krosmaster");
         if((this.configApi.isOptionalFeatureActive(feature.id)) && (this.uiApi.getUi("ArenaGameUi") == null))
         {
            this.uiApi.loadUi("ArenaGameUi","ArenaGameUi",[true],StrataEnum.STRATA_HIGH);
         }
      }
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var configApi:ConfigApi;
      
      public var sysApi:SystemApi;
   }
}
