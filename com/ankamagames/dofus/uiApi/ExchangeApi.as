package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.network.enums.ExchangeErrorEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;


   public class ExchangeApi extends Object implements IApi
   {
         

      public function ExchangeApi() {
         this._log=Log.getLogger(getQualifiedClassName(ExchangeApi));
         super();
      }



      protected var _log:Logger;

      private var _module:UiModule;

      public function set module(value:UiModule) : void {
         this._module=value;
      }

      public function destroy() : void {
         this._module=null;
      }

      public function getExchangeError(typeError:int) : String {
         switch(typeError)
         {
            case ExchangeErrorEnum.BID_SEARCH_ERROR:
               return "Erreur lors d\'une recherche dans l\'hotel de vente";
            case ExchangeErrorEnum.BUY_ERROR:
               return "Erreur lors d\'un achat";
            case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
               return "La requ�te d\'�change ne peut pas aboutir car l\'objet permetant de faire le craft n\'est pas �quip�";
            case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
               return "La requ�te d\'�change ne peut pas aboutir, le joueur n est pas enregistr�";
            case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
               return "La requ�te d\'�change ne peut pas aboutir car la cible est occup�e";
            case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
               return "La requ�te d\'�change ne peut pas aboutir, le joueur est \'overloaded?\'";
            case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
               return "La requ�te d\'�change ne peut pas aboutir, la machine est trop loin";
            case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
               return "La requ�te d\'�change ne peut pas aboutir";
            case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
               return "Erreur lors d\'une transaction avec une ferme";
            case ExchangeErrorEnum.SELL_ERROR:
               return "Erreur lors d\'une vente";
            default:
               return "Erreur d\'�change de type inconnue";
         }
      }
   }

}