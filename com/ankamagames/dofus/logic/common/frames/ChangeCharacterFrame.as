package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.common.actions.DirectSelectionCharacterAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.network.messages.game.context.notification.NotificationListMessage;
   import com.ankamagames.dofus.misc.utils.errormanager.WebServiceDataHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
   
   public class ChangeCharacterFrame extends Object implements Frame
   {
      
      public function ChangeCharacterFrame() {
         super();
      }
      
      public function get priority() : int {
         return 0;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:DirectSelectionCharacterAction = null;
         var _loc3_:LoginValidationAction = null;
         var _loc4_:LoginValidationAction = null;
         var _loc5_:ChangeCharacterAction = null;
         var _loc6_:LoginValidationAction = null;
         var _loc7_:LoginValidationAction = null;
         var _loc8_:LoginValidationAction = null;
         var _loc9_:LoginValidationAction = null;
         var _loc10_:NotificationListMessage = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         switch(true)
         {
            case param1 is DirectSelectionCharacterAction:
               _loc2_ = param1 as DirectSelectionCharacterAction;
               WebServiceDataHandler.getInstance().changeCharacter();
               PlayerManager.getInstance().allowAutoConnectCharacter = true;
               PlayerManager.getInstance().autoConnectOfASpecificCharacterId = _loc2_.characterId;
               _loc3_ = AuthentificationManager.getInstance().loginValidationAction;
               _loc4_ = LoginValidationAction.create(_loc3_.username,_loc3_.password,true,_loc2_.serverId);
               AuthentificationManager.getInstance().setValidationAction(_loc4_);
               SoundManager.getInstance().manager.removeAllSounds();
               ConnectionsHandler.closeConnection();
               Kernel.getWorker().resume();
               Kernel.getInstance().reset(null,(AuthentificationManager.getInstance().canAutoConnectWithToken) || !AuthentificationManager.getInstance().tokenMode);
               return true;
            case param1 is ChangeCharacterAction:
               _loc5_ = param1 as ChangeCharacterAction;
               WebServiceDataHandler.getInstance().changeCharacter();
               _loc6_ = AuthentificationManager.getInstance().loginValidationAction;
               _loc7_ = LoginValidationAction.create(_loc6_.username,_loc6_.password,true,_loc5_.serverId);
               AuthentificationManager.getInstance().setValidationAction(_loc7_);
               SoundManager.getInstance().manager.removeAllSounds();
               ConnectionsHandler.closeConnection();
               Kernel.getWorker().resume();
               Kernel.getInstance().reset(null,(AuthentificationManager.getInstance().canAutoConnectWithToken) || !AuthentificationManager.getInstance().tokenMode);
               return true;
            case param1 is ChangeServerAction:
               _loc8_ = AuthentificationManager.getInstance().loginValidationAction;
               _loc9_ = LoginValidationAction.create(_loc8_.username,_loc8_.password,false);
               AuthentificationManager.getInstance().setValidationAction(_loc9_);
               ConnectionsHandler.closeConnection();
               Kernel.getInstance().reset(null,(AuthentificationManager.getInstance().canAutoConnectWithToken) || !AuthentificationManager.getInstance().tokenMode);
               return true;
            case param1 is NotificationListMessage:
               _loc10_ = param1 as NotificationListMessage;
               QuestFrame.notificationList = new Array();
               _loc11_ = _loc10_.flags.length;
               _loc12_ = 0;
               while(_loc12_ < _loc11_)
               {
                  _loc13_ = _loc10_.flags[_loc12_];
                  _loc14_ = 0;
                  while(_loc14_ < 32)
                  {
                     QuestFrame.notificationList[_loc14_ + _loc12_ * 32] = Boolean(_loc13_ & 1);
                     _loc13_ = _loc13_ >> 1;
                     _loc14_++;
                  }
                  _loc12_++;
               }
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
