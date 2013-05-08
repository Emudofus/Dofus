package com.ankamagames.dofus.kernel.net
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.network.IServerConnection;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.connection.frames.HandshakeFrame;
   import com.ankamagames.jerakine.messages.ConnectionResumedMessage;
   import com.ankamagames.jerakine.network.IConnectionProxy;
   import com.ankamagames.jerakine.network.SnifferServerConnection;
   import com.ankamagames.jerakine.network.ProxyedServerConnection;
   import com.ankamagames.jerakine.network.ServerConnection;
   import com.ankamagames.dofus.logic.common.utils.LagometerAck;
   import com.ankamagames.dofus.network.MessageReceiver;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;


   public class ConnectionsHandler extends Object
   {
         

      public function ConnectionsHandler() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ConnectionsHandler));

      private static var _useSniffer:Boolean;

      private static var _currentConnection:IServerConnection;

      private static var _currentConnectionType:uint;

      private static var _wantedSocketLost:Boolean;

      private static var _wantedSocketLostReason:uint;

      private static var _hasReceivedMsg:Boolean = false;

      private static var _connectionTimeout:Timer;

      public static function get useSniffer() : Boolean {
         return _useSniffer;
      }

      public static function set useSniffer(sniffer:Boolean) : void {
         _useSniffer=sniffer;
      }

      public static function get connectionType() : uint {
         return _currentConnectionType;
      }

      public static function get hasReceivedMsg() : Boolean {
         return _hasReceivedMsg;
      }

      public static function set hasReceivedMsg(value:Boolean) : void {
         _hasReceivedMsg=value;
      }

      public static function getConnection() : IServerConnection {
         return _currentConnection;
      }

      public static function connectToLoginServer(host:String, port:uint) : void {
         if(_currentConnection!=null)
         {
            closeConnection();
         }
         etablishConnection(host,port,_useSniffer);
         _currentConnectionType=ConnectionType.TO_LOGIN_SERVER;
      }

      public static function connectToGameServer(gameServerHost:String, gameServerPort:uint) : void {
         if(!_connectionTimeout)
         {
            _connectionTimeout=new Timer(4000,1);
            _connectionTimeout.addEventListener(TimerEvent.TIMER,onConnectionTimeout);
         }
         else
         {
            _connectionTimeout.reset();
         }
         _connectionTimeout.start();
         _log.debug("Lancement du timer pour valider la connexion au serveur de jeu");
         if(_currentConnection!=null)
         {
            closeConnection();
         }
         etablishConnection(gameServerHost,gameServerPort,_useSniffer);
         _currentConnectionType=ConnectionType.TO_GAME_SERVER;
      }

      public static function confirmGameServerConnection() : void {
         _log.debug("Confirmation de la connexion au serveur de jeu, désactivation du timer");
         if(_connectionTimeout)
         {
            _connectionTimeout.stop();
         }
      }

      public static function onConnectionTimeout(e:TimerEvent) : void {
         var msg:BasicPingMessage = null;
         _log.debug("Expiration du timer de connexion au serveur de jeu");
         if((_currentConnection)&&(_currentConnection.connected))
         {
            msg=new BasicPingMessage();
            msg.initBasicPingMessage(true);
            _log.warn("La connection au serveur de jeu semble longue. On envoit un BasicPingMessage pour essayer de débloquer la situation.");
            _currentConnection.send(msg);
            if(_connectionTimeout)
            {
               _connectionTimeout.stop();
            }
         }
      }

      public static function closeConnection() : void {
         if(Kernel.getWorker().contains(HandshakeFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(HandshakeFrame));
         }
         if((_currentConnection)&&(_currentConnection.connected))
         {
            _currentConnection.close();
         }
         _currentConnection=null;
         _currentConnectionType=ConnectionType.DISCONNECTED;
      }

      public static function handleDisconnection() : DisconnectionReason {
         _log.debug("handleDisconnection");
         closeConnection();
         var reason:DisconnectionReason = new DisconnectionReason(_wantedSocketLost,_wantedSocketLostReason);
         _wantedSocketLost=false;
         _wantedSocketLostReason=DisconnectionReasonEnum.UNEXPECTED;
         return reason;
      }

      public static function connectionGonnaBeClosed(expectedReason:uint) : void {
         _wantedSocketLostReason=expectedReason;
         _wantedSocketLost=true;
      }

      public static function pause() : void {
         _log.debug("Pause connection");
         _currentConnection.pause();
      }

      public static function resume() : void {
         _log.debug("Resume connection");
         if(_currentConnection)
         {
            _currentConnection.resume();
         }
         Kernel.getWorker().process(new ConnectionResumedMessage());
      }

      private static function etablishConnection(host:String, port:int, useSniffer:Boolean=false, proxy:IConnectionProxy=null) : void {
         if(useSniffer)
         {
            if(proxy!=null)
            {
               throw new ArgumentError("Can\'t etablish a connection using a proxy and the sniffer.");
            }
            else
            {
               _currentConnection=new SnifferServerConnection();
            }
         }
         else
         {
            if(proxy!=null)
            {
               _currentConnection=new ProxyedServerConnection(proxy);
            }
            else
            {
               _currentConnection=new ServerConnection();
            }
         }
         _currentConnection.lagometer=new LagometerAck();
         _currentConnection.handler=Kernel.getWorker();
         _currentConnection.rawParser=new MessageReceiver();
         Kernel.getWorker().addFrame(new HandshakeFrame());
         _currentConnection.connect(host,port);
      }


   }

}