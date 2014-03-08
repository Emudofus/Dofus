package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitlesAndOrnamentsListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitlesAndOrnamentsListMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleGainedMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleLostMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentGainedMessage;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitleSelectRequestAction;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectRequestMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectedMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectErrorMessage;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.OrnamentSelectRequestAction;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectRequestMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectedMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectErrorMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitlesAndOrnamentsListRequestAction;
   
   public class TinselFrame extends Object implements Frame
   {
      
      public function TinselFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TinselFrame));
      
      private var _knownTitles:Vector.<uint>;
      
      private var _knownOrnaments:Vector.<uint>;
      
      private var _currentTitle:uint;
      
      private var _currentOrnament:uint;
      
      private var _titlesOrnamentsAskedBefore:Boolean;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get knownTitles() : Vector.<uint> {
         return this._knownTitles;
      }
      
      public function get knownOrnaments() : Vector.<uint> {
         return this._knownOrnaments;
      }
      
      public function get currentTitle() : uint {
         return this._currentTitle;
      }
      
      public function get currentOrnament() : uint {
         return this._currentOrnament;
      }
      
      public function get titlesOrnamentsAskedBefore() : Boolean {
         return this._titlesOrnamentsAskedBefore;
      }
      
      public function pushed() : Boolean {
         this._knownTitles = new Vector.<uint>();
         this._knownOrnaments = new Vector.<uint>();
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:TitlesAndOrnamentsListRequestMessage = null;
         var _loc3_:TitlesAndOrnamentsListMessage = null;
         var _loc4_:TitleGainedMessage = null;
         var _loc5_:String = null;
         var _loc6_:TitleLostMessage = null;
         var _loc7_:* = 0;
         var _loc8_:OrnamentGainedMessage = null;
         var _loc9_:String = null;
         var _loc10_:TitleSelectRequestAction = null;
         var _loc11_:TitleSelectRequestMessage = null;
         var _loc12_:TitleSelectedMessage = null;
         var _loc13_:TitleSelectErrorMessage = null;
         var _loc14_:OrnamentSelectRequestAction = null;
         var _loc15_:OrnamentSelectRequestMessage = null;
         var _loc16_:OrnamentSelectedMessage = null;
         var _loc17_:OrnamentSelectErrorMessage = null;
         var _loc18_:* = 0;
         switch(true)
         {
            case param1 is TitlesAndOrnamentsListRequestAction:
               _loc2_ = new TitlesAndOrnamentsListRequestMessage();
               _loc2_.initTitlesAndOrnamentsListRequestMessage();
               ConnectionsHandler.getConnection().send(_loc2_);
               return true;
            case param1 is TitlesAndOrnamentsListMessage:
               _loc3_ = param1 as TitlesAndOrnamentsListMessage;
               this._titlesOrnamentsAskedBefore = true;
               this._knownTitles = _loc3_.titles;
               this._knownOrnaments = _loc3_.ornaments;
               this._currentTitle = _loc3_.activeTitle;
               this._currentOrnament = _loc3_.activeOrnament;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated,this._knownTitles);
               KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated,this._knownOrnaments);
               return true;
            case param1 is TitleGainedMessage:
               _loc4_ = param1 as TitleGainedMessage;
               this._knownTitles.push(_loc4_.titleId);
               _loc5_ = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.titleUnlockWithLink"),[_loc4_.titleId]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc5_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated,this._knownTitles);
               return true;
            case param1 is TitleLostMessage:
               _loc6_ = param1 as TitleLostMessage;
               _loc7_ = 0;
               for each (_loc18_ in this._knownTitles)
               {
                  if(_loc18_ == _loc6_.titleId)
                  {
                     break;
                  }
                  _loc7_++;
               }
               this._knownTitles.splice(_loc7_,1);
               if(this._currentTitle == _loc6_.titleId)
               {
                  this._currentTitle = 0;
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated,this._knownTitles);
               return true;
            case param1 is OrnamentGainedMessage:
               _loc8_ = param1 as OrnamentGainedMessage;
               this._knownOrnaments.push(_loc8_.ornamentId);
               _loc9_ = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.ornamentUnlockWithLink"),[_loc8_.ornamentId]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc9_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated,this._knownOrnaments);
               return true;
            case param1 is TitleSelectRequestAction:
               _loc10_ = param1 as TitleSelectRequestAction;
               _loc11_ = new TitleSelectRequestMessage();
               _loc11_.initTitleSelectRequestMessage(_loc10_.titleId);
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is TitleSelectedMessage:
               _loc12_ = param1 as TitleSelectedMessage;
               this._currentTitle = _loc12_.titleId;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitleUpdated,this._currentTitle);
               return true;
            case param1 is TitleSelectErrorMessage:
               _loc13_ = param1 as TitleSelectErrorMessage;
               _log.debug("erreur de selection de titre");
               return true;
            case param1 is OrnamentSelectRequestAction:
               _loc14_ = param1 as OrnamentSelectRequestAction;
               _loc15_ = new OrnamentSelectRequestMessage();
               _loc15_.initOrnamentSelectRequestMessage(_loc14_.ornamentId);
               ConnectionsHandler.getConnection().send(_loc15_);
               return true;
            case param1 is OrnamentSelectedMessage:
               _loc16_ = param1 as OrnamentSelectedMessage;
               this._currentOrnament = _loc16_.ornamentId;
               KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentUpdated,this._currentOrnament);
               return true;
            case param1 is OrnamentSelectErrorMessage:
               _loc17_ = param1 as OrnamentSelectErrorMessage;
               _log.debug("erreur de selection d\'ornement");
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
