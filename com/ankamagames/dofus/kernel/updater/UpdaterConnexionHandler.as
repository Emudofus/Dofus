package com.ankamagames.dofus.kernel.updater
{
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.approach.frames.*;
    import com.ankamagames.dofus.logic.game.approach.managers.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.events.*;
    import flash.utils.*;

    public class UpdaterConnexionHandler extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterConnexionHandler));
        private static var _self:UpdaterConnexionHandler;
        private static var _currentConnection:ServerConnection;

        public function UpdaterConnexionHandler()
        {
            if (!_self)
            {
                _currentConnection = new ServerConnection();
                _currentConnection.addEventListener(IOErrorEvent.IO_ERROR, this.onIoError);
                _currentConnection.addEventListener(Event.CONNECT, this.onConnect);
                _currentConnection.handler = Kernel.getWorker();
                _currentConnection.rawParser = new MessageReceiver();
                Kernel.getWorker().addFrame(new UpdaterDialogFrame());
                if (CommandLineArguments.getInstance().hasArgument("update-server-port"))
                {
                    _log.debug("update-server-port");
                    _currentConnection.connect("localhost", int(CommandLineArguments.getInstance().getArgument("update-server-port")));
                }
                else
                {
                    _log.debug("default port");
                    _currentConnection.connect("localhost", 4242);
                }
            }
            else
            {
                throw new Error("La classe UpdaterConnexionHandler est un singleton");
            }
            return;
        }// end function

        public function onConnect(event:Event) : void
        {
            StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION, "success");
            PartManager.getInstance().initialize();
            return;
        }// end function

        public function onIoError(event:IOErrorEvent) : void
        {
            if (CommandLineArguments.getInstance().hasArgument("update-server-port"))
            {
                StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION, "failed");
            }
            else
            {
                StatisticReportingManager.getInstance().report("UpdaterConnexion - " + BuildInfos.BUILD_TYPE + " - " + BuildInfos.BUILD_VERSION, "noupdater");
            }
            _log.error("Can\'t etablish connection with updater");
            return;
        }// end function

        public static function getInstance() : UpdaterConnexionHandler
        {
            if (!_self)
            {
                _self = new UpdaterConnexionHandler;
            }
            return _self;
        }// end function

        public static function getConnection() : ServerConnection
        {
            return _currentConnection;
        }// end function

    }
}
