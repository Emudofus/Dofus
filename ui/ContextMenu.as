package 
{
   import flash.display.Sprite;
   import contextMenu.ContextMenuTitle;
   import contextMenu.ContextMenuItem;
   import contextMenu.ContextMenuPictureItem;
   import contextMenu.ContextMenuPictureLabelItem;
   import contextMenu.ContextMenuSeparator;
   import ui.ContextMenuUi;
   import d2api.SystemApi;
   import d2api.ConfigApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.AlignmentApi;
   import d2api.FightApi;
   import d2api.PlayedCharacterApi;
   import d2api.ContextMenuApi;
   import d2api.MapApi;
   import d2api.JobsApi;
   import d2api.SocialApi;
   import d2api.MountApi;
   import d2api.TimeApi;
   import d2api.RoleplayApi;
   import d2api.PartyApi;
   import d2api.BindsApi;
   import d2api.StorageApi;
   import makers.HumanVendorMenuMaker;
   import makers.MultiPlayerMenuMaker;
   import makers.PlayerMenuMaker;
   import makers.AccountMenuMaker;
   import makers.ItemMenuMaker;
   import makers.PaddockItemMenuMaker;
   import makers.NpcMenuMaker;
   import makers.TaxCollectorMenuMaker;
   import makers.PrismMenuMaker;
   import makers.PortalMenuMaker;
   import makers.SkillMenuMaker;
   import makers.PartyMemberMenuMaker;
   import makers.MountMenuMaker;
   import makers.WorldMenuMaker;
   import makers.FightWorldMenuMaker;
   import makers.MapFlagMenuMaker;
   import makers.MonsterGroupMenuMaker;
   import makers.CompanionMenuMaker;
   import contextMenu.ContextMenuManager;
   import d2hooks.*;
   
   public class ContextMenu extends Sprite
   {
      
      public function ContextMenu() {
         super();
      }
      
      public static function static_createContextMenuTitleObject(label:String) : ContextMenuTitle {
         return new ContextMenuTitle(label);
      }
      
      public static function static_createContextMenuItemObject(label:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = true, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuItem {
         return new ContextMenuItem(label,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public static function static_createContextMenuPictureItemObject(uri:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureItem {
         return new ContextMenuPictureItem(uri,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public static function static_createContextMenuPictureLabelItemObject(uri:String, label:String, textureSize:int, after:Boolean = false, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureLabelItem {
         return new ContextMenuPictureLabelItem(uri,label,textureSize,after,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public static function static_createContextMenuSeparatorObject() : ContextMenuSeparator {
         return new ContextMenuSeparator();
      }
      
      private var include_ContextMenuUi:ContextMenuUi = null;
      
      public var sysApi:SystemApi;
      
      public var configApi:ConfigApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var alignApi:AlignmentApi;
      
      public var fightApi:FightApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var menuApi:ContextMenuApi;
      
      public var mapApi:MapApi;
      
      public var jobsApi:JobsApi;
      
      public var socialApi:SocialApi;
      
      public var mountApi:MountApi;
      
      public var timeApi:TimeApi;
      
      public var modCommon:Object;
      
      public var roleplayApi:RoleplayApi;
      
      public var partyApi:PartyApi;
      
      public var bindsApi:BindsApi;
      
      public var storageApi:StorageApi;
      
      public function main() : void {
         Api.system = this.sysApi;
         Api.config = this.configApi;
         Api.ui = this.uiApi;
         Api.menu = this.menuApi;
         Api.data = this.dataApi;
         Api.alignment = this.alignApi;
         Api.fight = this.fightApi;
         Api.player = this.playerApi;
         Api.map = this.mapApi;
         Api.social = this.socialApi;
         Api.jobs = this.jobsApi;
         Api.mount = this.mountApi;
         Api.modCommon = this.modCommon;
         Api.roleplay = this.roleplayApi;
         Api.party = this.partyApi;
         Api.binds = this.bindsApi;
         Api.time = this.timeApi;
         Api.storage = this.storageApi;
         Api.modMenu = this;
         this.sysApi.createHook("OpeningContextMenu");
         this.menuApi.registerMenuMaker("humanVendor",HumanVendorMenuMaker);
         this.menuApi.registerMenuMaker("multiplayer",MultiPlayerMenuMaker);
         this.menuApi.registerMenuMaker("player",PlayerMenuMaker);
         this.menuApi.registerMenuMaker("mutant",PlayerMenuMaker);
         this.menuApi.registerMenuMaker("account",AccountMenuMaker);
         this.menuApi.registerMenuMaker("item",ItemMenuMaker);
         this.menuApi.registerMenuMaker("paddockItem",PaddockItemMenuMaker);
         this.menuApi.registerMenuMaker("npc",NpcMenuMaker);
         this.menuApi.registerMenuMaker("taxCollector",TaxCollectorMenuMaker);
         this.menuApi.registerMenuMaker("prism",PrismMenuMaker);
         this.menuApi.registerMenuMaker("portal",PortalMenuMaker);
         this.menuApi.registerMenuMaker("skill",SkillMenuMaker);
         this.menuApi.registerMenuMaker("partyMember",PartyMemberMenuMaker);
         this.menuApi.registerMenuMaker("mount",MountMenuMaker);
         this.menuApi.registerMenuMaker("world",WorldMenuMaker);
         this.menuApi.registerMenuMaker("fightWorld",FightWorldMenuMaker);
         this.menuApi.registerMenuMaker("mapFlag",MapFlagMenuMaker);
         this.menuApi.registerMenuMaker("monsterGroup",MonsterGroupMenuMaker);
         this.menuApi.registerMenuMaker("companion",CompanionMenuMaker);
      }
      
      public function getMenuMaker(label:String) : Object {
         return this.menuApi.getMenuMaker(label);
      }
      
      public function createContextMenuTitleObject(label:String) : ContextMenuTitle {
         return static_createContextMenuTitleObject(label);
      }
      
      public function createContextMenuItemObject(label:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = true, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuItem {
         return static_createContextMenuItemObject(label,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public function createContextMenuPictureItemObject(uri:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = null, forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureItem {
         return static_createContextMenuPictureItemObject(uri,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public function createContextMenuPictureLabelItemObject(uri:String, label:String, textureSize:int, after:Boolean, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = false, help:String = "", forceCloseOnSelect:Boolean = false, helpDelay:uint = 1000) : ContextMenuPictureLabelItem {
         return static_createContextMenuPictureLabelItemObject(uri,label,textureSize,after,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect,helpDelay);
      }
      
      public function createContextMenuSeparatorObject() : ContextMenuSeparator {
         return static_createContextMenuSeparatorObject();
      }
      
      public function closeAllMenu() : void {
         ContextMenuManager.getInstance().closeAll();
      }
      
      public function createContextMenu(menu:*, positionReference:Object = null, closeCallBack:Function = null) : void {
         if(menu == null)
         {
            return;
         }
         if(menu is Array)
         {
            menu = this.menuApi.create(null,null,menu);
         }
         try
         {
            this.sysApi.dispatchHook(OpeningContextMenu,menu);
         }
         catch(e:Error)
         {
            sysApi.log(8,"Context menu exception : " + e);
         }
         var resultMenu:* = menu is Array?menu:menu.content;
         ContextMenuManager.getInstance().openNew(resultMenu,positionReference,closeCallBack);
      }
      
      public function unload() : void {
         Api.ui = null;
         Api.system = null;
         Api.config = null;
         Api.menu = null;
         Api.data = null;
         Api.alignment = null;
         Api.fight = null;
         Api.player = null;
         Api.map = null;
         Api.mount = null;
         Api.social = null;
         Api.jobs = null;
         Api.modCommon = null;
         Api.roleplay = null;
         Api.party = null;
         Api.binds = null;
      }
   }
}
