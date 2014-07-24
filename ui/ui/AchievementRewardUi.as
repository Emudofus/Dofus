package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.QuestApi;
   import d2api.UtilApi;
   import d2api.PlayedCharacterApi;
   import d2api.SocialApi;
   import d2api.ContextMenuApi;
   import d2api.AveragePricesApi;
   import flash.utils.Dictionary;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.Texture;
   import d2data.AchievementCategory;
   import d2network.GuildMember;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import d2data.ItemWrapper;
   import d2data.EmoteWrapper;
   import d2data.SpellWrapper;
   import d2data.TitleWrapper;
   import d2data.OrnamentWrapper;
   import d2network.AchievementRewardable;
   import d2data.Achievement;
   import d2data.AchievementReward;
   import d2enums.LocationEnum;
   
   public class AchievementRewardUi extends Object
   {
      
      public function AchievementRewardUi() {
         this._rewardsObjectsList = new Dictionary(true);
         this._btnAcceptRewardList = new Dictionary(true);
         this._lblNameList = new Dictionary(true);
         this._dataCategories = new Array();
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var questApi:QuestApi;
      
      public var utilApi:UtilApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var socialApi:SocialApi;
      
      public var menuApi:ContextMenuApi;
      
      public var averagePricesApi:AveragePricesApi;
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      private var _rewardsObjectsList:Dictionary;
      
      private var _btnAcceptRewardList:Dictionary;
      
      private var _lblNameList:Dictionary;
      
      private var _dataCategories:Array;
      
      private var _myGuildXp:int;
      
      public var gd_achievements:Grid;
      
      public var btn_acceptAll:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_remains:Label;
      
      public var tx_generalBg:Texture;
      
      public var tx_gridBg:Texture;
      
      public var tx_gridFg:Texture;
      
      public function main(param:Object = null) : void {
         var cat:AchievementCategory = null;
         var meMember:GuildMember = null;
         var myId:* = 0;
         var mem:GuildMember = null;
         this.sysApi.addHook(AchievementRewardSuccess,this.onAchievementRewardSuccess);
         this.sysApi.addHook(GuildInformationsMemberUpdate,this.onGuildInformationsMemberUpdate);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_acceptAll,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_acceptAll,ComponentHookList.ON_ROLL_OUT);
         if(this.socialApi.hasGuild())
         {
            myId = this.playerApi.id();
            for each(mem in this.socialApi.getGuildMembers())
            {
               if(mem.id == myId)
               {
                  meMember = mem;
                  break;
               }
            }
            this._myGuildXp = meMember.experienceGivenPercent;
         }
         for each(this._dataCategories[cat.id] in this.dataApi.getAchievementCategories())
         {
         }
         this.updateAchievementList(true);
      }
      
      public function unload() : void {
         this.uiApi.hideTooltip();
      }
      
      public function updateAchievementLine(data:*, compRef:*, selected:Boolean) : void {
         var cat:AchievementCategory = null;
         var rewardsSlotContent:Array = null;
         var i:* = 0;
         var rewardId:uint = 0;
         var item:ItemWrapper = null;
         var emote:EmoteWrapper = null;
         var spell:SpellWrapper = null;
         var title:TitleWrapper = null;
         var ornament:OrnamentWrapper = null;
         if(data)
         {
            cat = data.achievement.category;
            if(cat.parentId != 0)
            {
               cat = this._dataCategories[cat.parentId];
            }
            compRef.lbl_title.text = data.achievement.name;
            compRef.lbl_category.text = cat.name;
            compRef.lbl_title.handCursor = true;
            compRef.lbl_rewardsKama.text = this.utilApi.formateIntToString(data.kamas);
            compRef.lbl_rewardsXp.text = this.utilApi.formateIntToString(data.xp);
            rewardsSlotContent = new Array();
            if(data.rewardData)
            {
               i = 0;
               while(i < data.rewardData.itemsReward.length)
               {
                  item = this.dataApi.getItemWrapper(data.rewardData.itemsReward[i],0,0,data.rewardData.itemsQuantityReward[i]);
                  rewardsSlotContent.push(item);
                  i++;
               }
               for each(rewardId in data.rewardData.emotesReward)
               {
                  emote = this.dataApi.getEmoteWrapper(rewardId);
                  rewardsSlotContent.push(emote);
               }
               for each(rewardId in data.rewardData.spellsReward)
               {
                  spell = this.dataApi.getSpellWrapper(rewardId);
                  rewardsSlotContent.push(spell);
               }
               for each(rewardId in data.rewardData.titlesReward)
               {
                  title = this.dataApi.getTitleWrapper(rewardId);
                  rewardsSlotContent.push(title);
               }
               for each(rewardId in data.rewardData.ornamentsReward)
               {
                  ornament = this.dataApi.getOrnamentWrapper(rewardId);
                  rewardsSlotContent.push(ornament);
               }
            }
            compRef.gd_rewards.dataProvider = rewardsSlotContent;
            if(!this._rewardsObjectsList[compRef.gd_rewards.name])
            {
               this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OUT);
            }
            this._rewardsObjectsList[compRef.gd_rewards.name] = data;
            if(!this._btnAcceptRewardList[compRef.btn_acceptOne.name])
            {
               this.uiApi.addComponentHook(compRef.btn_acceptOne,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(compRef.btn_acceptOne,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.btn_acceptOne,ComponentHookList.ON_ROLL_OUT);
            }
            this._btnAcceptRewardList[compRef.btn_acceptOne.name] = data.achievement.id;
            if(!this._lblNameList[compRef.lbl_title.name])
            {
               this.uiApi.addComponentHook(compRef.lbl_title,ComponentHookList.ON_RELEASE);
            }
            this._lblNameList[compRef.lbl_title.name] = data.achievement.id;
            compRef.ctr_achievement.visible = true;
         }
         else
         {
            compRef.ctr_achievement.visible = false;
         }
      }
      
      public function updateAchievementList(firstOpening:Boolean = false) : void {
         var rewardable:AchievementRewardable = null;
         var nbLineToRemove:* = 0;
         var lineHeight:* = 0;
         var ach:Achievement = null;
         var reward:Object = null;
         var rewardId:* = 0;
         var r:AchievementReward = null;
         var dp:Array = new Array();
         var apiRewardablesList:Object = this.questApi.getRewardableAchievements();
         if(apiRewardablesList.length == 0)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return;
         }
         if((firstOpening) && (apiRewardablesList.length < 4))
         {
            nbLineToRemove = 4 - apiRewardablesList.length;
            lineHeight = int(this.uiApi.me().getConstant("height_line"));
            this.tx_generalBg.height = int(this.uiApi.me().getConstant("height_tx_generalBg")) - nbLineToRemove * lineHeight;
            this.tx_gridBg.height = int(this.uiApi.me().getConstant("height_tx_gridBg")) - nbLineToRemove * lineHeight;
            this.tx_gridFg.height = this.tx_gridBg.height;
            this.gd_achievements.height = int(this.uiApi.me().getConstant("height_grid")) - nbLineToRemove * lineHeight;
         }
         for each(rewardable in apiRewardablesList)
         {
            ach = this.dataApi.getAchievement(rewardable.id);
            reward = 
               {
                  "achievement":ach,
                  "rewardData":null,
                  "kamas":0,
                  "xp":0
               };
            for each(rewardId in ach.rewardIds)
            {
               r = this.dataApi.getAchievementReward(rewardId);
               if(r)
               {
                  if(((r.levelMin == -1) || (r.levelMin <= rewardable.finishedlevel)) && ((r.levelMax >= rewardable.finishedlevel) || (r.levelMax == -1)))
                  {
                     reward.rewardData = r;
                     break;
                  }
               }
            }
            reward.kamas = this.questApi.getAchievementKamasReward(ach,rewardable.finishedlevel);
            reward.xp = this.questApi.getAchievementExperienceReward(ach,rewardable.finishedlevel);
            dp.push(reward);
         }
         this.gd_achievements.dataProvider = dp;
         this.lbl_remains.text = this.uiApi.processText(this.uiApi.getText("ui.achievement.rewardsRemaining",dp.length),"n",dp.length <= 1);
      }
      
      private function getMountPercentXp() : int {
         var xpRatio:* = 0;
         if((!(this.playerApi.getMount() == null)) && (this.playerApi.isRidding()) && (this.playerApi.getMount().xpRatio > 0))
         {
            xpRatio = this.playerApi.getMount().xpRatio;
         }
         return xpRatio;
      }
      
      public function onAchievementRewardSuccess(achievementId:int) : void {
         this.updateAchievementList();
      }
      
      public function onGuildInformationsMemberUpdate(member:Object) : void {
         if(member.id == this.playerApi.id())
         {
            this._myGuildXp = member.experienceGivenPercent;
         }
      }
      
      public function onRelease(target:Object) : void {
         var data:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_acceptAll:
               this.sysApi.sendAction(new AchievementRewardRequest(-1));
               break;
            default:
               if(target.name.indexOf("btn_acceptOne") != -1)
               {
                  this.sysApi.sendAction(new AchievementRewardRequest(this._btnAcceptRewardList[target.name]));
               }
               else if(target.name.indexOf("lbl_title") != -1)
               {
                  data = new Object();
                  data.achievementId = this._lblNameList[target.name];
                  data.forceOpen = true;
                  this.sysApi.sendAction(new OpenBook("achievementTab",data));
               }
               
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         if(target.name.indexOf("btn_acceptOne") != -1)
         {
            text = this.uiApi.getText("ui.achievement.rewardsGet");
         }
         var myMountXp:int = this.getMountPercentXp();
         if((target == this.btn_acceptAll) && (myMountXp) || (this._myGuildXp))
         {
            text = this.uiApi.getText("ui.popup.warning");
         }
         if(myMountXp)
         {
            text = text + ("\n" + this.uiApi.getText("ui.achievement.mountXpPercent",myMountXp));
         }
         if(this._myGuildXp)
         {
            text = text + ("\n" + this.uiApi.getText("ui.achievement.guildXpPercent",this._myGuildXp));
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:Object, item:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if((item.data) && (!(target.name.indexOf("gd_rewards") == -1)))
         {
            data = item.data;
            if((data == null) || (!(data is ItemWrapper)))
            {
               return;
            }
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var text:String = null;
         var pos:Object = null;
         if((item.data) && (!(target.name.indexOf("gd_rewards") == -1)))
         {
            pos = 
               {
                  "point":LocationEnum.POINT_BOTTOM,
                  "relativePoint":LocationEnum.POINT_TOP
               };
            if(item.data is ItemWrapper)
            {
               text = item.data.name;
               text = text + this.averagePricesApi.getItemAveragePriceString(item.data,true);
            }
            else if(item.data is EmoteWrapper)
            {
               text = this.uiApi.getText("ui.common.emote",item.data.emote.name);
            }
            else if(item.data is SpellWrapper)
            {
               text = this.uiApi.getText("ui.common.spell",item.data.spell.name);
            }
            else if(item.data is TitleWrapper)
            {
               text = this.uiApi.getText("ui.common.title",item.data.title.name);
            }
            else if(item.data is OrnamentWrapper)
            {
               text = this.uiApi.getText("ui.common.ornament",item.data.name);
            }
            
            
            
            
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
   }
}
