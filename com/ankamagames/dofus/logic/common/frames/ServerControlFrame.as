package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.security.RawDataMessage;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.dofus.network.messages.game.script.URLOpenMessage;
   import com.ankamagames.dofus.datacenter.misc.Url;
   import com.ankamagames.dofus.network.messages.secure.TrustStatusMessage;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   import flash.net.URLRequest;
   import com.ankamagames.dofus.datacenter.misc.OptionalFeature;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   import flash.system.ApplicationDomain;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.net.navigateToURL;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
   import com.ankamagames.dofus.logic.shield.SecureModeManager;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class ServerControlFrame extends Object implements Frame
   {
      
      public function ServerControlFrame() {
         super();
      }
      
      protected static const _log:Logger;
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var rdMsg:RawDataMessage = null;
         var content:ByteArray = null;
         var signature:Signature = null;
         var urlmsg:URLOpenMessage = null;
         var urlData:Url = null;
         var tsMsg:TrustStatusMessage = null;
         var l:Loader = null;
         var lc:LoaderContext = null;
         var req:URLRequest = null;
         var f:MiscFrame = null;
         var feature:OptionalFeature = null;
         switch(true)
         {
            case msg is RawDataMessage:
               rdMsg = msg as RawDataMessage;
               if(Kernel.getWorker().contains(AuthentificationFrame))
               {
                  return false;
               }
               content = new ByteArray();
               signature = new Signature(SignedFileAdapter.defaultSignatureKey);
               if(signature.verify(rdMsg.content,content))
               {
                  l = new Loader();
                  lc = new LoaderContext(false,ApplicationDomain.currentDomain);
                  AirScanner.allowByteCodeExecution(lc,true);
                  l.loadBytes(content,lc);
               }
               return true;
            case msg is URLOpenMessage:
               urlmsg = msg as URLOpenMessage;
               urlData = Url.getUrlById(urlmsg.urlId);
               switch(urlData.browserId)
               {
                  case 1:
                     req = new URLRequest(urlData.url);
                     req.method = urlData.method == ""?"GET":urlData.method.toUpperCase();
                     req.data = urlData.variables;
                     navigateToURL(req);
                     return true;
                  case 2:
                     KernelEventsManager.getInstance().processCallback(HookList.OpenWebPortal,WebLocationEnum.WEB_LOCATION_OGRINE);
                     return true;
                  case 3:
                     return true;
                  case 4:
                     if(HookList[urlData.url])
                     {
                        f = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
                        feature = OptionalFeature.getOptionalFeatureByKeyword("game.krosmasterGameInClient");
                        if((f && feature) && (!f.isOptionalFeatureActive(feature.id)) && (HookList.OpenKrosmaster == HookList[urlData.url]))
                        {
                           _log.error("Tentative de lancement de Krosmaster, cependant la feature n\'est pas active");
                           return true;
                        }
                        KernelEventsManager.getInstance().processCallback(HookList[urlData.url]);
                     }
                     return true;
                  default:
                     return true;
               }
            case msg is TrustStatusMessage:
               tsMsg = msg as TrustStatusMessage;
               SecureModeManager.getInstance().active = !tsMsg.trusted;
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
   }
}
