package 
{
   import flash.display.Sprite;
   import adminMenu.AdminMenu;
   import ui.AdminSelectItem;
   import d2api.FileApi;
   import d2api.SystemApi;
   import d2api.RoleplayApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.DataApi;
   import d2data.ContextMenuData;
   import flash.utils.Dictionary;
   import d2hooks.*;
   
   public class Admin extends Sprite
   {
      
      public function Admin() {
         super();
      }
      
      private static var _self:Admin;
      
      private static var _adminMenu:AdminMenu;
      
      public static function getInstance() : Admin {
         return _self;
      }
      
      private var _include_SelectItem:AdminSelectItem = null;
      
      public var fileApi:FileApi;
      
      public var sysApi:SystemApi;
      
      public var roleplayApi:RoleplayApi;
      
      public var uiApi:UiApi;
      
      public var playedCharacterApi:PlayedCharacterApi;
      
      public var dataApi:DataApi;
      
      public var contextMod:Object;
      
      public var consoleMod:Object;
      
      public function main(... args) : void {
         if(!this.sysApi.hasRight())
         {
            return;
         }
         _self = this;
         Api.fileApi = this.fileApi;
         Api.uiApi = this.uiApi;
         Api.systemApi = this.sysApi;
         Api.dataApi = this.dataApi;
         Api.contextMod = this.contextMod;
         Api.consoleMod = this.consoleMod;
         _adminMenu = new AdminMenu();
         this.sysApi.addHook(MapComplementaryInformationsData,this.onGameStart);
         this.sysApi.addHook(OpeningContextMenu,this.onOpeningContextMenu);
      }
      
      public function reloadXml() : void {
         _adminMenu = new AdminMenu();
      }
      
      private function onOpeningContextMenu(contextMenuData:ContextMenuData) : void {
         var info:Object = null;
         var newMenu:Array = null;
         var elem:Object = null;
         var data:Object = null;
         var playerInfos:Dictionary = null;
         var entity:Object = null;
         var cellId:uint = 0;
         var entities:Object = null;
         var subMenu:Object = null;
         var infos:Object = null;
         if(contextMenuData)
         {
            info = new Object();
            info.m = this.playedCharacterApi.currentMap().mapId;
            info.n = this.playedCharacterApi.getPlayedCharacterInfo().name;
            info.s = this.sysApi.getCurrentServer().name;
            info.v = this.sysApi.getCurrentVersion();
            if(contextMenuData.makerName == "player")
            {
               if(contextMenuData.data)
               {
                  data = contextMenuData.data;
                  if(data.hasOwnProperty("name"))
                  {
                     info.p = data.name;
                  }
                  if(data is String)
                  {
                     info.p = data;
                  }
                  if((data.hasOwnProperty("humanoidInfo")) && (data.humanoidInfo.hasOwnProperty("guildInformations")) && (data.humanoidInfo.guildInformations) && (data.humanoidInfo.guildInformations.guildName))
                  {
                     info.g = data.humanoidInfo.guildInformations.guildName;
                  }
               }
               newMenu = _adminMenu.process(info);
               for each(elem in newMenu)
               {
                  contextMenuData.content.push(elem);
               }
            }
            else if(contextMenuData.makerName == "multiplayer")
            {
               playerInfos = new Dictionary();
               entity = this.roleplayApi.getEntityByName(contextMenuData.data.name);
               cellId = entity.position.cellId;
               entities = this.roleplayApi.getEntitiesOnCell(cellId);
               for each(entity in entities)
               {
                  if(entity.id > 0)
                  {
                     infos = this.roleplayApi.getEntityInfos(entity);
                     if(!infos.hasOwnProperty("fight"))
                     {
                        playerInfos[infos.name] = infos;
                     }
                  }
               }
               for each(subMenu in contextMenuData.content)
               {
                  info = new Object();
                  data = playerInfos[subMenu.label];
                  if(data.hasOwnProperty("name"))
                  {
                     info.p = data.name;
                  }
                  if(data is String)
                  {
                     info.p = data;
                  }
                  if((data.hasOwnProperty("humanoidInfo")) && (data.humanoidInfo.hasOwnProperty("guildInformations")) && (data.humanoidInfo.guildInformations) && (data.humanoidInfo.guildInformations.guildName))
                  {
                     info.g = data.humanoidInfo.guildInformations.guildName;
                  }
                  subMenu.child = subMenu.child.concat(_adminMenu.process(info));
               }
            }
            
         }
      }
      
      private function onGameStart(... args) : void {
         this.sysApi.removeHook(MapComplementaryInformationsData);
         _adminMenu.onStart();
      }
   }
}
