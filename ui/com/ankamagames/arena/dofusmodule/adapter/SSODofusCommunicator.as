package com.ankamagames.arena.dofusmodule.adapter
{
   import flash.events.EventDispatcher;
   import d2actions.KrosmasterTokenRequest;
   import d2enums.KrosmasterErrorEnum;
   import com.ankamagames.arena.dofusmodule.event.SSODofusEvent;
   import d2hooks.KrosmasterAuthToken;
   import d2hooks.KrosmasterAuthTokenError;
   import d2api.SystemApi;
   
   public class SSODofusCommunicator extends EventDispatcher implements ISSOCommunicator
   {
      
      public function SSODofusCommunicator(sysApi:SystemApi) {
         super();
         this._sysApi = sysApi;
         this.init();
      }
      
      public static const EVT_SSO_TOKEN_RECEIVED:String = "com.ankamagames.arena.dofusmodule.adapter.SSODofusCommunicator.EVT_SSO_TOKEN_RECEIVED";
      
      public function destroy() : void {
         this._sysApi = null;
      }
      
      public function ssoTokenRequest() : void {
         this._sysApi.sendAction(new KrosmasterTokenRequest());
      }
      
      public function onErrorReceived(reason:int) : void {
         trace("SSO COMMUNICATOR : error : " + reason);
         switch(reason)
         {
            case KrosmasterErrorEnum.KROSMASTER_ERROR_ICE_KO:
               trace("SSO COMMUNICATOR : error : ICE_KO");
               break;
            case KrosmasterErrorEnum.KROSMASTER_ERROR_ICE_REFUSED:
               trace("SSO COMMUNICATOR : error : ICE_REFUSED");
               break;
            default:
               trace("SSO COMMUNICATOR : error : UNDEFINED");
         }
      }
      
      public function onTokenReceived(token:String) : void {
         trace("SSO COMMUNICATOR : received : " + token);
         dispatchEvent(new SSODofusEvent(EVT_SSO_TOKEN_RECEIVED,this._sysApi.getNickname(),token,1));
      }
      
      private function init() : void {
         this._sysApi.addHook(KrosmasterAuthToken,this.onTokenReceived);
         this._sysApi.addHook(KrosmasterAuthTokenError,this.onErrorReceived);
      }
      
      private var _sysApi:SystemApi;
   }
}
