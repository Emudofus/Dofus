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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ConnectionsHandler));
      
      private static var _useSniffer:Boolean;
      
      private static var _currentConnection:MultiConnection;
      
      private static var _currentConnectionType:String;
      
      private static var _wantedSocketLost:Boolean;
      
      private static var _wantedSocketLostReason:uint;
      
      private static var _hasReceivedMsg:Boolean = false;
      
      private static var _connectionTimeout:Timer;
      
      private static var _currentHttpConnection:HttpServerConnection = new HttpServerConnection();
      
      public static function get useSniffer() : Boolean {
         return _useSniffer;
      }
      
      public static function set useSniffer(param1:Boolean) : void {
         _useSniffer = param1;
      }
      
      public static function get connectionType() : String {
         return _currentConnectionType;
      }
      
      public static function get hasReceivedMsg() : Boolean {
         return _hasReceivedMsg;
      }
      
      public static function set hasReceivedMsg(param1:Boolean) : void {
         _hasReceivedMsg = param1;
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
      
      public static function connectToLoginServer(param1:String, param2:uint) : void {
         if(_currentConnection != null)
         {
            closeConnection();
         }
         etablishConnection(param1,param2,ConnectionType.TO_LOGIN_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_LOGIN_SERVER;
      }
      
      public static function connectToGameServer(param1:String, param2:uint) : void {
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
         etablishConnection(param1,param2,ConnectionType.TO_GAME_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_GAME_SERVER;
      }
      
      public static function connectToKoliServer(param1:String, param2:uint) : void {
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
         if(!(_currentConnection == null) && (_currentConnection.getSubConnection(ConnectionType.TO_KOLI_SERVER)))
         {
            _currentConnection.close(ConnectionType.TO_KOLI_SERVER);
         }
         etablishConnection(param1,param2,ConnectionType.TO_KOLI_SERVER,_useSniffer);
         _currentConnectionType = ConnectionType.TO_GAME_SERVER;
      }
      
      public static function confirmGameServerConnection() : void {
         if(_connectionTimeout)
         {
            _connectionTimeout.stop();
         }
      }
      
      public static function onConnectionTimeout(param1:TimerEvent) : void {
         var _loc2_:BasicPingMessage = null;
         if((_currentConnection) && (_currentConnection.connected))
         {
            _loc2_ = new BasicPingMessage();
            _loc2_.initBasicPingMessage(true);
            _log.warn("La connection au serveur de jeu semble longue. On envoit un BasicPingMessage pour essayer de débloquer la situation.");
            _currentConnection.send(_loc2_);
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
         var _loc1_:DisconnectionReason = new DisconnectionReason(_wantedSocketLost,_wantedSocketLostReason);
         _wantedSocketLost = false;
         _wantedSocketLostReason = DisconnectionReasonEnum.UNEXPECTED;
         return _loc1_;
      }
      
      public static function connectionGonnaBeClosed(param1:uint) : void {
         _wantedSocketLostReason = param1;
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
      
      private static function etablishConnection(param1:String, param2:int, param3:String, param4:Boolean=false, param5:IConnectionProxy=null) : void {
         var _loc6_:IServerConnection = null;
         if(param4)
         {
            if(param5 != null)
            {
               throw new ArgumentError("Can\'t etablish a connection using a proxy and the sniffer.");
            }
            else
            {
               _loc6_ = new SnifferServerConnection();
            }
         }
         else
         {
            if(param5 != null)
            {
               _loc6_ = new ProxyedServerConnection(param5);
            }
            else
            {
               _loc6_ = new ServerConnection();
            }
         }
         if(!_currentConnection)
         {
            _currentConnection = new MultiConnection();
         }
         _loc6_.lagometer = new LagometerAck();
         _loc6_.handler = Kernel.getWorker();
         _loc6_.rawParser = new MessageReceiver();
         _currentConnection.addConnection(_loc6_,param3);
         _currentConnection.mainConnection = _loc6_;
         Kernel.getWorker().addFrame(new HandshakeFrame());
         _loc6_.connect(param1,param2);
      }
   }
}
