package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.network.messages.game.context.notification.NotificationListMessage;
   import com.ankamagames.dofus.misc.utils.errormanager.WebServiceDataHandler;
   import com.ankamagames.jerakine.data.XmlConfig;
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

      public function process(msg:Message) : Boolean {
         var loginMode:String = null;
         var cca:ChangeCharacterAction = null;
         var lvacca:LoginValidationAction = null;
         var lvaccaNew:LoginValidationAction = null;
         var lvacha:LoginValidationAction = null;
         var lvachaNew:LoginValidationAction = null;
         var nlmsg:NotificationListMessage = null;
         var num:* = 0;
         var c:* = 0;
         var val:* = 0;
         var bit:* = 0;
         switch(true)
         {
            case msg is ChangeCharacterAction:
               cca=msg as ChangeCharacterAction;
               WebServiceDataHandler.getInstance().changeCharacter();
               loginMode=XmlConfig.getInstance().getEntry("config.loginMode");
               lvacca=AuthentificationManager.getInstance().loginValidationAction;
               lvaccaNew=LoginValidationAction.create(lvacca.username,lvacca.password,true,cca.serverId);
               AuthentificationManager.getInstance().setValidationAction(lvaccaNew);
               SoundManager.getInstance().manager.removeAllSounds();
               ConnectionsHandler.closeConnection();
               Kernel.getWorker().resume();
               Kernel.getInstance().reset(null,(AuthentificationManager.getInstance().canAutoConnectWithToken)||(!AuthentificationManager.getInstance().tokenMode));
               return true;
            case msg is ChangeServerAction:
               lvacha=AuthentificationManager.getInstance().loginValidationAction;
               lvachaNew=LoginValidationAction.create(lvacha.username,lvacha.password,false);
               AuthentificationManager.getInstance().setValidationAction(lvachaNew);
               ConnectionsHandler.closeConnection();
               Kernel.getInstance().reset(null,(AuthentificationManager.getInstance().canAutoConnectWithToken)||(!AuthentificationManager.getInstance().tokenMode));
               return true;
            case msg is NotificationListMessage:
               nlmsg=msg as NotificationListMessage;
               QuestFrame.notificationList=new Array();
               num=nlmsg.flags.length;
               c=0;
               while(c<num)
               {
                  val=nlmsg.flags[c];
                  bit=0;
                  while(bit<32)
                  {
                     QuestFrame.notificationList[bit+c*32]=Boolean(val&1);
                     val=val>>1;
                     bit++;
                  }
                  c++;
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