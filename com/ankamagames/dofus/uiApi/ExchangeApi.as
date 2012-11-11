package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ExchangeApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function ExchangeApi()
        {
            this._log = Log.getLogger(getQualifiedClassName());
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getExchangeError(param1:int) : String
        {
            switch(param1)
            {
                case ExchangeErrorEnum.BID_SEARCH_ERROR:
                {
                    return "Erreur lors d\'une recherche dans l\'hotel de vente";
                }
                case ExchangeErrorEnum.BUY_ERROR:
                {
                    return "Erreur lors d\'un achat";
                }
                case ExchangeErrorEnum.REQUEST_CHARACTER_JOB_NOT_EQUIPED:
                {
                    return "La requête d\'échange ne peut pas aboutir car l\'objet permetant de faire le craft n\'est pas équipé";
                }
                case ExchangeErrorEnum.REQUEST_CHARACTER_NOT_SUSCRIBER:
                {
                    return "La requête d\'échange ne peut pas aboutir, le joueur n est pas enregistré";
                }
                case ExchangeErrorEnum.REQUEST_CHARACTER_OCCUPIED:
                {
                    return "La requête d\'échange ne peut pas aboutir car la cible est occupée";
                }
                case ExchangeErrorEnum.REQUEST_CHARACTER_OVERLOADED:
                {
                    return "La requête d\'échange ne peut pas aboutir, le joueur est \'overloaded?\'";
                }
                case ExchangeErrorEnum.REQUEST_CHARACTER_TOOL_TOO_FAR:
                {
                    return "La requête d\'échange ne peut pas aboutir, la machine est trop loin";
                }
                case ExchangeErrorEnum.REQUEST_IMPOSSIBLE:
                {
                    return "La requête d\'échange ne peut pas aboutir";
                }
                case ExchangeErrorEnum.MOUNT_PADDOCK_ERROR:
                {
                    return "Erreur lors d\'une transaction avec une ferme";
                }
                case ExchangeErrorEnum.SELL_ERROR:
                {
                    return "Erreur lors d\'une vente";
                }
                default:
                {
                    break;
                }
            }
            return "Erreur d\'échange de type inconnue";
        }// end function

    }
}
