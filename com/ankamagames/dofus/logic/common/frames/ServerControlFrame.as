package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.utils.crypto.SignatureKey;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.messages.security.RawDataMessage;
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
    import by.blooddy.crypto.MD5;
    import flash.system.ApplicationDomain;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import flash.net.navigateToURL;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
    import com.ankamagames.dofus.logic.shield.SecureModeManager;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.types.enums.Priority;

    public class ServerControlFrame implements Frame 
    {

        private static const PUBLIC_KEY:Class = ServerControlFrame_PUBLIC_KEY;
        private static const SIGNATURE_KEY:SignatureKey = SignatureKey.fromByte((new PUBLIC_KEY() as ByteArray));
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerControlFrame));


        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:RawDataMessage;
            var _local_3:ByteArray;
            var _local_4:Signature;
            var _local_5:URLOpenMessage;
            var _local_6:Url;
            var _local_7:TrustStatusMessage;
            var l:Loader;
            var lc:LoaderContext;
            var _local_10:URLRequest;
            var f:MiscFrame;
            var feature:OptionalFeature;
            switch (true)
            {
                case (msg is RawDataMessage):
                    _local_2 = (msg as RawDataMessage);
                    if (Kernel.getWorker().contains(AuthentificationFrame))
                    {
                        _log.error("Impossible de traiter le paquet RawDataMessage durant cette phase.");
                        return (false);
                    };
                    _local_3 = new ByteArray();
                    _local_4 = new Signature(SIGNATURE_KEY);
                    _log.info(((("Bytecode len: " + _local_2.content.length) + ", hash: ") + MD5.hashBytes(_local_2.content)));
                    _local_2.content.position = 0;
                    if (_local_4.verify(_local_2.content, _local_3))
                    {
                        l = new Loader();
                        lc = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
                        AirScanner.allowByteCodeExecution(lc, true);
                        l.loadBytes(_local_3, lc);
                    }
                    else
                    {
                        _log.error("Signature incorrecte");
                    };
                    return (true);
                case (msg is URLOpenMessage):
                    _local_5 = (msg as URLOpenMessage);
                    _local_6 = Url.getUrlById(_local_5.urlId);
                    switch (_local_6.browserId)
                    {
                        case 1:
                            _local_10 = new URLRequest(_local_6.url);
                            _local_10.method = (((_local_6.method)=="") ? "GET" : _local_6.method.toUpperCase());
                            _local_10.data = _local_6.variables;
                            navigateToURL(_local_10);
                            return (true);
                        case 2:
                            KernelEventsManager.getInstance().processCallback(HookList.OpenWebPortal, WebLocationEnum.WEB_LOCATION_OGRINE);
                            return (true);
                        case 3:
                            return (true);
                        case 4:
                            if (HookList[_local_6.url])
                            {
                                f = (Kernel.getWorker().getFrame(MiscFrame) as MiscFrame);
                                feature = OptionalFeature.getOptionalFeatureByKeyword("game.krosmasterGameInClient");
                                if (((((((f) && (feature))) && (!(f.isOptionalFeatureActive(feature.id))))) && ((HookList.OpenKrosmaster == HookList[_local_6.url]))))
                                {
                                    _log.error("Tentative de lancement de Krosmaster, cependant la feature n'est pas active");
                                    return (true);
                                };
                                KernelEventsManager.getInstance().processCallback(HookList[_local_6.url]);
                            };
                            return (true);
                    };
                    return (true);
                case (msg is TrustStatusMessage):
                    _local_7 = (msg as TrustStatusMessage);
                    SecureModeManager.getInstance().active = !(_local_7.trusted);
                    return (true);
            };
            return (false);
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }


    }
}//package com.ankamagames.dofus.logic.common.frames

