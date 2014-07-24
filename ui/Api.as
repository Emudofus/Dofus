package 
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.PlayedCharacterApi;
   import d2api.DataApi;
   import d2api.HighlightApi;
   import d2api.FightApi;
   import d2api.StorageApi;
   import d2api.BindsApi;
   
   public class Api extends Object
   {
      
      public function Api() {
         super();
      }
      
      public static var ui:UiApi;
      
      public static var system:SystemApi;
      
      public static var modMenu:Object;
      
      public static var player:PlayedCharacterApi;
      
      public static var data:DataApi;
      
      public static var highlight:HighlightApi;
      
      public static var fight:FightApi;
      
      public static var storage:StorageApi;
      
      public static var binds:BindsApi;
   }
}
