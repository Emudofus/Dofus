package ui
{
   import d2api.BindsApi;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.SoundApi;
   import d2api.PlayedCharacterApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2hooks.*;
   import d2actions.*;
   
   public class SocialBase extends Object
   {
      
      public function SocialBase() {
         super();
      }
      
      private static var _shortcutColor:String;
      
      public var bindsApi:BindsApi;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var socialApi:SocialApi;
      
      public var soundApi:SoundApi;
      
      public var playerApi:PlayedCharacterApi;
      
      private var _currentTabUi:int = -1;
      
      private var _hasGuild:Boolean;
      
      private var _hasAlliance:Boolean;
      
      private var _hasSpouse:Boolean;
      
      private var _friendList:Object;
      
      public var uiCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_tabFriend:ButtonContainer;
      
      public var btn_tabGuild:ButtonContainer;
      
      public var btn_tabAlliance:ButtonContainer;
      
      public var btn_tabSpouse:ButtonContainer;
      
      public var btn_tabDirectory:ButtonContainer;
      
      public function main(params:Object) : void {
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.soundApi.playSound(SoundTypeEnum.SOCIAL_OPEN);
         this.btn_tabFriend.soundId = SoundEnum.TAB;
         this.btn_tabGuild.soundId = SoundEnum.TAB;
         this.btn_tabAlliance.soundId = SoundEnum.TAB;
         this.btn_tabSpouse.soundId = SoundEnum.TAB;
         this.btn_tabDirectory.soundId = SoundEnum.TAB;
         this.sysApi.addHook(SpouseUpdated,this.onSpouseUpdated);
         this.sysApi.addHook(GuildMembershipUpdated,this.onGuildMembershipUpdated);
         this.sysApi.addHook(AllianceMembershipUpdated,this.onAllianceMembershipUpdated);
         this.uiApi.addComponentHook(this.btn_tabFriend,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabFriend,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabFriend,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabGuild,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabGuild,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabGuild,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabAlliance,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabAlliance,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabAlliance,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabSpouse,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabSpouse,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabSpouse,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabDirectory,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabDirectory,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabDirectory,"onRollOut");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialFriends",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialGuild",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialAlliance",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialSpouse",this.onShortcut);
         this.sysApi.disableWorldInteraction();
         this._hasGuild = this.socialApi.hasGuild();
         this._hasAlliance = this.socialApi.hasAlliance();
         this._hasSpouse = this.socialApi.hasSpouse();
         this.displayTabs();
         this._currentTabUi = -2;
         if((params) && (params.hasOwnProperty("tab")))
         {
            if(params.hasOwnProperty("subTab"))
            {
               if((params.hasOwnProperty("params")) && (!(params.params == null)))
               {
                  this.openTab(params.tab,params.subTab,params.params);
               }
               else
               {
                  this.openTab(params.tab,params.subTab);
               }
            }
            else
            {
               this.openTab(params.tab);
            }
         }
         else
         {
            this.openTab(-1);
         }
      }
      
      public function unload() : void {
         this.sysApi.sendAction(new GuildFightLeaveRequest(0,this.playerApi.id(),true));
         this.sysApi.sendAction(new PrismFightJoinLeaveRequest(0,false));
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         this.closeTab(this._currentTabUi);
         this.sysApi.enableWorldInteraction();
      }
      
      public function getTab() : int {
         return this._currentTabUi;
      }
      
      private function displayTabs() : void {
         if(this.btn_tabGuild.disabled == this._hasGuild)
         {
            this.btn_tabGuild.disabled = !this._hasGuild;
         }
         if(this.btn_tabAlliance.disabled == this._hasAlliance)
         {
            this.btn_tabAlliance.disabled = !this._hasAlliance;
         }
         if(this.btn_tabSpouse.disabled == this._hasSpouse)
         {
            this.btn_tabSpouse.disabled = !this._hasSpouse;
         }
         if((this._currentTabUi == 1) && (this.btn_tabGuild.disabled))
         {
            this.openTab(0);
         }
         if((this._currentTabUi == 2) && (this.btn_tabAlliance.disabled))
         {
            this.openTab(0);
         }
         if((this._currentTabUi == 3) && (this.btn_tabSpouse.disabled))
         {
            this.openTab(0);
         }
      }
      
      public function openTab(tab:int = -1, subTab:int = 0, params:Object = null) : void {
         var lastTab:uint = 0;
         if((!(tab == -1)) && ((this._currentTabUi == tab) || (this.getButtonByTab(tab).disabled)))
         {
            return;
         }
         if(this._currentTabUi > -1)
         {
            this.uiApi.unloadUi("subSocialUi");
         }
         if(tab == -1)
         {
            lastTab = this.sysApi.getData("lastSocialTab");
            if((lastTab) && (!this.getButtonByTab(lastTab).disabled))
            {
               this._currentTabUi = lastTab;
            }
            else
            {
               this._currentTabUi = 0;
            }
         }
         else
         {
            this._currentTabUi = tab;
         }
         if(this._currentTabUi == 0)
         {
            this.sysApi.sendAction(new FriendsListRequest());
            this.sysApi.sendAction(new EnemiesListRequest());
         }
         if(this._currentTabUi == 2)
         {
            this.sysApi.sendAction(new AllianceInsiderInfoRequest());
         }
         if(this._currentTabUi == 3)
         {
            this.sysApi.sendAction(new SpouseRequest());
         }
         if(this._currentTabUi == 4)
         {
         }
         this.sysApi.setData("lastSocialTab",this._currentTabUi);
         this.uiApi.loadUiInside(this.getUiNameByTab(this._currentTabUi),this.uiCtr,"subSocialUi",[subTab,params]);
         this.uiApi.setRadioGroupSelectedItem("tabGroup",this.getButtonByTab(this._currentTabUi),this.uiApi.me());
         this.getButtonByTab(this._currentTabUi).selected = true;
      }
      
      private function closeTab(tab:uint) : void {
         this.uiApi.unloadUi("subSocialUi");
      }
      
      private function getButtonByTab(tab:uint) : Object {
         var returnButton:Object = null;
         switch(tab)
         {
            case 0:
               returnButton = this.btn_tabFriend;
               break;
            case 1:
               returnButton = this.btn_tabGuild;
               break;
            case 2:
               returnButton = this.btn_tabAlliance;
               break;
            case 3:
               returnButton = this.btn_tabSpouse;
               break;
            case 4:
               returnButton = this.btn_tabDirectory;
               break;
         }
         return returnButton;
      }
      
      private function getUiNameByTab(tab:uint) : String {
         var uiName:String = null;
         switch(tab)
         {
            case 0:
               uiName = "friends";
               break;
            case 1:
               uiName = "guild";
               break;
            case 2:
               uiName = "alliance";
               break;
            case 3:
               uiName = "spouse";
               break;
            case 4:
               uiName = "directory";
               break;
         }
         return uiName;
      }
      
      private function closeSocial() : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function onGuildMembershipUpdated(hasGuild:Boolean) : void {
         this._hasGuild = hasGuild;
         this.displayTabs();
      }
      
      private function onAllianceMembershipUpdated(hasAlliance:Boolean) : void {
         this._hasAlliance = hasAlliance;
         this.displayTabs();
      }
      
      private function onSpouseUpdated() : void {
         this._hasSpouse = this.socialApi.hasSpouse();
         this.displayTabs();
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.closeSocial();
               break;
            case this.btn_tabFriend:
               this.openTab(0);
               break;
            case this.btn_tabGuild:
               this.openTab(1);
               break;
            case this.btn_tabAlliance:
               this.openTab(2);
               break;
            case this.btn_tabSpouse:
               this.openTab(3);
               break;
            case this.btn_tabDirectory:
               this.openTab(4);
               break;
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "openSocialFriends":
               if(this._currentTabUi == 0)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(0);
               }
               return true;
            case "openSocialGuild":
               if(this._currentTabUi == 1)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(1);
               }
               return true;
            case "openSocialAlliance":
               if(this._currentTabUi == 2)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               else
               {
                  this.openTab(2);
               }
               return true;
            case "openSocialSpouse":
               if(this._currentTabUi == 3)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
                  return true;
               }
               if(this.socialApi.getSpouse() != null)
               {
                  this.openTab(3);
                  return true;
               }
               return false;
            case "closeUi":
               this.closeSocial();
               return true;
            default:
               return false;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var data:Object = null;
         var spouse:Object = null;
         var point:uint = 5;
         var relPoint:uint = 3;
         var shortcutKey:String = null;
         switch(target)
         {
            case this.btn_tabFriend:
               tooltipText = this.uiApi.getText("ui.common.friends");
               shortcutKey = this.bindsApi.getShortcutBindStr("openSocialFriends");
               break;
            case this.btn_tabGuild:
               tooltipText = this.uiApi.getText("ui.common.guild");
               shortcutKey = this.bindsApi.getShortcutBindStr("openSocialGuild");
               break;
            case this.btn_tabAlliance:
               tooltipText = this.uiApi.getText("ui.common.alliance");
               shortcutKey = this.bindsApi.getShortcutBindStr("openSocialAlliance");
               break;
            case this.btn_tabSpouse:
               spouse = this.socialApi.getSpouse();
               if(spouse != null)
               {
                  tooltipText = this.uiApi.processText(this.uiApi.getText("ui.common.spouse"),spouse.sex > 0?"f":"m",true);
               }
               else
               {
                  tooltipText = this.uiApi.processText(this.uiApi.getText("ui.common.spouse"),"m",true);
               }
               shortcutKey = this.bindsApi.getShortcutBindStr("openSocialSpouse");
               break;
            case this.btn_tabDirectory:
               tooltipText = this.uiApi.getText("ui.common.directory");
               break;
         }
         if(shortcutKey)
         {
            if(!_shortcutColor)
            {
               _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
               _shortcutColor = _shortcutColor.replace("0x","#");
            }
            data = this.uiApi.textTooltipInfo(tooltipText + " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>");
         }
         else
         {
            data = this.uiApi.textTooltipInfo(tooltipText);
         }
         this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
