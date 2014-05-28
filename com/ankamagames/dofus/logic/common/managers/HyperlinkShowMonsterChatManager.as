package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   
   public class HyperlinkShowMonsterChatManager extends Object
   {
      
      public function HyperlinkShowMonsterChatManager() {
         super();
      }
      
      protected static const _log:Logger;
      
      private static var _monsterList:Array;
      
      private static var _monsterId:uint = 0;
      
      public static function showMonster(monsterId:uint) : void {
         var data:Object = new Object();
         data.monsterId = monsterId;
         data.forceOpen = true;
         KernelEventsManager.getInstance().processCallback(HookList.OpenBook,"bestiaryTab",data);
      }
      
      public static function addMonster(monsterId:uint) : String {
         var code:String = null;
         var monster:Monster = Monster.getMonsterById(monsterId);
         if(monster)
         {
            _monsterList[_monsterId] = monster;
            code = "{chatmonster," + monsterId + "::[" + monster.name + "]}";
            _monsterId++;
            return code;
         }
         return "[null]";
      }
      
      public static function getMonsterName(monsterId:uint) : String {
         var monster:Monster = Monster.getMonsterById(monsterId);
         if(monster)
         {
            return "[" + monster.name + "]";
         }
         return "[null]";
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, monsterId:uint = 0) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.monster"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
