package com.ankamagames.dofus.kernel.net
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.utils.*;
    import com.ankamagames.dofus.logic.connection.frames.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.messages.common.basic.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import flash.events.*;
    import flash.utils.*;

    public class ConnectionsHandler extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ConnectionsHandler));
        private static var _useSniffer:Boolean;
        private static var _currentConnection:IServerConnection;
        private static var _currentConnectionType:uint;
        private static var _wantedSocketLost:Boolean;
        private static var _wantedSocketLostReason:uint;
        private static var _hasReceivedMsg:Boolean = false;
        private static var _connectionTimeout:Timer;

        public function ConnectionsHandler()
        {
            return;
        }// end function

        public static function get useSniffer() : Boolean
        {
            return _useSniffer;
        }// end function

        public static function set useSniffer(param1:Boolean) : void
        {
            _useSniffer = param1;
            return;
        }// end function

        public static function get connectionType() : uint
        {
            return _currentConnectionType;
        }// end function

        public static function get hasReceivedMsg() : Boolean
        {
            return _hasReceivedMsg;
        }// end function

        public static function set hasReceivedMsg(param1:Boolean) : void
        {
            _hasReceivedMsg = param1;
            return;
        }// end function

        public static function getConnection() : IServerConnection
        {
            return _currentConnection;
        }// end function

        public static function connectToLoginServer(param1:String, param2:uint) : void
        {
            if (_currentConnection != null)
            {
                closeConnection();
            }
            etablishConnection(param1, param2, _useSniffer);
            _currentConnectionType = ConnectionType.TO_LOGIN_SERVER;
            return;
        }// end function

        public static function connectToGameServer(param1:String, param2:uint) : void
        {
            if (!_connectionTimeout)
            {
                _connectionTimeout = new Timer(4000, 1);
                _connectionTimeout.addEventListener(TimerEvent.TIMER, onConnectionTimeout);
            }
            else
            {
                _connectionTimeout.reset();
            }
            _connectionTimeout.start();
            _log.debug("Lancement du timer pour valider la connexion au serveur de jeu");
            if (_currentConnection != null)
            {
                closeConnection();
            }
            etablishConnection(param1, param2, _useSniffer);
            _currentConnectionType = ConnectionType.TO_GAME_SERVER;
            return;
        }// end function

        public static function confirmGameServerConnection() : void
        {
            _log.debug("Confirmation de la connexion au serveur de jeu, désactivation du timer");
            if (_connectionTimeout)
            {
                _connectionTimeout.stop();
            }
            return;
        }// end function

        public static function onConnectionTimeout(event:TimerEvent) : void
        {
            var _loc_2:BasicPingMessage = null;
            _log.debug("Expiration du timer de connexion au serveur de jeu");
            if (_currentConnection && _currentConnection.connected)
            {
                _loc_2 = new BasicPingMessage();
                _loc_2.initBasicPingMessage(true);
                _log.warn("La connection au serveur de jeu semble longue. On envoit un BasicPingMessage pour essayer de débloquer la situation.");
                _currentConnection.send(_loc_2);
                if (_connectionTimeout)
                {
                    _connectionTimeout.stop();
                }
            }
            return;
        }// end function

        public static function closeConnection() : void
        {
            if (Kernel.getWorker().contains(HandshakeFrame))
            {
                Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(HandshakeFrame));
            }
            if (_currentConnection && _currentConnection.connected)
            {
                _currentConnection.close();
            }
            _currentConnection = null;
            _currentConnectionType = ConnectionType.DISCONNECTED;
            return;
        }// end function

        public static function handleDisconnection() : DisconnectionReason
        {
            _log.debug("handleDisconnection");
            closeConnection();
            var _loc_1:* = new DisconnectionReason(_wantedSocketLost, _wantedSocketLostReason);
            _wantedSocketLost = false;
            _wantedSocketLostReason = DisconnectionReasonEnum.UNEXPECTED;
            return _loc_1;
        }// end function

        public static function connectionGonnaBeClosed(param1:uint) : void
        {
            _wantedSocketLostReason = param1;
            _wantedSocketLost = true;
            return;
        }// end function

        public static function pause() : void
        {
            _log.debug("Pause connection");
            _currentConnection.pause();
            return;
        }// end function

        public static function resume() : void
        {
            _log.debug("Resume connection");
            _currentConnection.resume();
            Kernel.getWorker().process(new ConnectionResumedMessage());
            return;
        }// end function

        private static function etablishConnection(param1:String, param2:int, param3:Boolean = false, param4:IConnectionProxy = null) : void
        {
            if (param3)
            {
                if (param4 != null)
                {
                    throw new ArgumentError("Can\'t etablish a connection using a proxy and the sniffer.");
                }
                _currentConnection = new SnifferServerConnection();
            }
            else if (param4 != null)
            {
                _currentConnection = new ProxyedServerConnection(param4);
            }
            else
            {
                _currentConnection = new ServerConnection();
            }
            _currentConnection.lagometer = new Lagometer();
            _currentConnection.handler = Kernel.getWorker();
            _currentConnection.rawParser = new MessageReceiver();
            Kernel.getWorker().addFrame(new HandshakeFrame());
            _currentConnection.connect(param1, param2);
            return;
        }// end function

    }
}
