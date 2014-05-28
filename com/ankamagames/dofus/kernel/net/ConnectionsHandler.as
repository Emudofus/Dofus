package com.ankamagames.dofus.kernel.net
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.network.MultiConnection;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.network.HttpServerConnection;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.MessageReceiver;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.dofus.logic.connection.frames.HandshakeFrame;
   import com.ankamagames.jerakine.messages.ConnectionResumedMessage;
   import com.ankamagames.jerakine.network.IConnectionProxy;
   import com.ankamagames.jerakine.network.IServerConnection;
   import com.ankamagames.jerakine.network.SnifferServerConnection;
   import com.ankamagames.jerakine.network.ProxyedServerConnection;
   import com.ankamagames.jerakine.network.ServerConnection;
   import com.ankamagames.dofus.logic.common.utils.LagometerAck;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ConnectionsHandler extends Object
   {
      
      public function ConnectionsHandler() {
         super();
      }
      
      public static const GAME_SERVER:String = "game_server";
      
      public static const KOLI_SERVER:String = "koli_server";
      
      protected static const _log:Logger;
      
      private static var _useSniffer:Boolean;
      
      private static var _currentConnection:MultiConnection;
      
      private static var _currentConnectionType:String;
      
      private static var _wantedSocketLost:Boolean;
      
      private static var _wantedSocketLostReason:uint;
      
      private static var _hasReceivedMsg:Boolean = false;
      
      private static var _connectionTimeout:Timer;
      
      private static var _currentHttpConnection:HttpServerConnection;
      
      public static function get useSniffer() : Boolean {
         return _useSniffer;
      }
      
      public static function set useSniffer(sniffer:Boolean) : void {
         _useSniffer = sniffer;
      }
      
      public static function get connectionType() : String {
         return _currentConnectionType;
      }
      
      public static function get hasReceivedMsg() : Boolean {
         return _hasReceivedMsg;
      }
      
      public static function set hasReceivedMsg(value:Boolean) : void {
         _hasReceivedMsg = value;
      }
      
      public static function getConnection() : MultiConnection {
         if(!_currentConnection)
         {
            _currentConnection = new MultiConnection();
         }
         return _currentConnection;
      }
      
      public static function getHttpConnection() : HttpServerConnection {
         if(!_currentHttpConnection.handler)
         {
            _currentHttpConnection.handler = Kernel.getWorker();
            _currentHttpConnection.rawParser = new MessageReceiver();
         }
         return _currentHttpConnection;
      }
      
      public static function connectToLoginServer(host:String, port:uint) : void {
         if(_currentConnection != null)
         {
            closeConnection();
         }
         etablishConnection(host,port,ConnectionType.TO_LOGIN_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_LOGIN_SERVER;
      }
      
      public static function connectToGameServer(gameServerHost:String, gameServerPort:uint) : void {
         if(!_connectionTimeout)
         {
            _connectionTimeout = new Timer(4000,1);
            _connectionTimeout.addEventListener(TimerEvent.TIMER,onConnectionTimeout);
         }
         else
         {
            _connectionTimeout.reset();
         }
         _connectionTimeout.start();
         if(_currentConnection != null)
         {
            closeConnection();
         }
         etablishConnection(gameServerHost,gameServerPort,ConnectionType.TO_GAME_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_GAME_SERVER;
      }
      
      public static function connectToKoliServer(gameServerHost:String, gameServerPort:uint) : void {
         if(!_connectionTimeout)
         {
            _connectionTimeout = new Timer(4000,1);
            _connectionTimeout.addEventListener(TimerEvent.TIMER,onConnectionTimeout);
         }
         else
         {
            _connectionTimeout.reset();
         }
         _connectionTimeout.start();
         if((!(_currentConnection == null)) && (_currentConnection.getSubConnection(ConnectionType.TO_KOLI_SERVER)))
         {
            _currentConnection.close(ConnectionType.TO_KOLI_SERVER);
         }
         etablishConnection(gameServerHost,gameServerPort,ConnectionType.TO_KOLI_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_GAME_SERVER;
      }
      
      public static function confirmGameServerConnection() : void {
         if(_connectionTimeout)
         {
            _connectionTimeout.stop();
         }
      }
      
      public static function onConnectionTimeout(e:TimerEvent) : void {
         var msg:BasicPingMessage = null;
         if((_currentConnection) && (_currentConnection.connected))
         {
            msg = new BasicPingMessage();
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
         if((_currentConnection) && (_currentConnection.connected))
         {
            _currentConnection.close();
         }
         _currentConnection = null;
         _currentConnectionType = ConnectionType.DISCONNECTED;
      }
      
      public static function handleDisconnection() : DisconnectionReason {
         closeConnection();
         var reason:DisconnectionReason = new DisconnectionReason(_wantedSocketLost,_wantedSocketLostReason);
         _wantedSocketLost = false;
         _wantedSocketLostReason = DisconnectionReasonEnum.UNEXPECTED;
         return reason;
      }
      
      public static function connectionGonnaBeClosed(expectedReason:uint) : void {
         _wantedSocketLostReason = expectedReason;
         _wantedSocketLost = true;
      }
      
      public static function pause() : void {
         _log.info("Pause connection");
         _currentConnection.pause();
      }
      
      public static function resume() : void {
         _log.info("Resume connection");
         if(_currentConnection)
         {
            _currentConnection.resume();
         }
         Kernel.getWorker().process(new ConnectionResumedMessage());
      }
      
      private static function etablishConnection(host:String, port:int, id:String, useSniffer:Boolean = false, proxy:IConnectionProxy = null) : void {
         var conn:IServerConnection = null;
         if(useSniffer)
         {
            if(proxy != null)
            {
               throw new ArgumentError("Can\'t etablish a connection using a proxy and the sniffer.");
            }
            else
            {
               conn = new SnifferServerConnection();
            }
         }
         else if(proxy != null)
         {
            conn = new ProxyedServerConnection(proxy);
         }
         else
         {
            conn = new ServerConnection();
         }
         
         if(!_currentConnection)
         {
            _currentConnection = new MultiConnection();
         }
         conn.lagometer = new LagometerAck();
         conn.handler = Kernel.getWorker();
         conn.rawParser = new MessageReceiver();
         _currentConnection.addConnection(conn,id);
         _currentConnection.mainConnection = conn;
         Kernel.getWorker().addFrame(new HandshakeFrame());
         conn.connect(host,port);
      }
   }
}
