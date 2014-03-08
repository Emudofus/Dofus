package com.ankamagames.jerakine.network
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.events.IEventDispatcher;
   import com.ankamagames.jerakine.messages.Message;
   import flash.events.Event;
   
   public class MultiConnection extends EventDispatcher
   {
      
      public function MultiConnection() {
         this._connectionByMsg = new Dictionary(true);
         this._connectionByEvent = new Dictionary(true);
         this._connectionById = new Dictionary();
         this._idByConnection = new Dictionary();
         super(this);
      }
      
      private var _connectionByMsg:Dictionary;
      
      private var _connectionByEvent:Dictionary;
      
      private var _connectionById:Dictionary;
      
      private var _idByConnection:Dictionary;
      
      private var _connectionCount:uint;
      
      private var _mainConnection:IServerConnection;
      
      private var _messageRouter:IMessageRouter;
      
      private var _connectionConnectedCount:int;
      
      public function get mainConnection() : IServerConnection {
         return this._mainConnection;
      }
      
      public function set mainConnection(conn:IServerConnection) : void {
         if(!this._idByConnection[conn])
         {
            throw new ArgumentError("Connection must be added before setted to be the main connection");
         }
         else
         {
            this._mainConnection = conn;
            return;
         }
      }
      
      public function get messageRouter() : IMessageRouter {
         return this._messageRouter;
      }
      
      public function set messageRouter(mr:IMessageRouter) : void {
         this._messageRouter = mr;
      }
      
      public function get connected() : Boolean {
         return !(this._connectionConnectedCount == 0);
      }
      
      public function get connectionCount() : uint {
         return this._connectionCount;
      }
      
      public function addConnection(conn:IServerConnection, id:String) : void {
         var e:* = undefined;
         if(this._connectionById[id])
         {
            this.removeConnection(id);
         }
         if(this._idByConnection[conn])
         {
            this.removeConnection(conn);
         }
         this._connectionById[id] = conn;
         this._idByConnection[conn] = id;
         this._connectionCount++;
         conn.handler = new MessageWatcher(this.proccessMsg,conn.handler,conn);
         for each (e in DescribeTypeCache.typeDescription(conn)..metadata.(@name == "Event").arg.(@key == "").@value)
         {
            IEventDispatcher(conn).addEventListener(e.toString(),this.onSubConnectionEvent);
         }
         if(conn.connected)
         {
            this._connectionConnectedCount++;
         }
      }
      
      public function removeConnection(idOrConnection:*) : Boolean {
         var id:String = null;
         var conn:IServerConnection = null;
         var e:* = undefined;
         if(idOrConnection is String)
         {
            id = idOrConnection;
            conn = this.getSubConnection(idOrConnection);
         }
         if(idOrConnection is IServerConnection)
         {
            id = this._idByConnection[idOrConnection];
            conn = idOrConnection;
         }
         if(!conn)
         {
            return false;
         }
         for each (e in DescribeTypeCache.typeDescription(conn)..metadata.(@name == "Event").arg.(@key == "").@value)
         {
            IEventDispatcher(conn).removeEventListener(e.toString(),this.onSubConnectionEvent);
         }
         this._connectionCount--;
         if(conn.connected)
         {
            this._connectionConnectedCount--;
         }
         if(this._mainConnection == conn)
         {
            this._mainConnection = null;
         }
         delete this._connectionById[[id]];
         delete this._idByConnection[[conn]];
         if(conn.handler is MultiConnection)
         {
            conn.handler = MessageWatcher(conn.handler).handler;
         }
         return true;
      }
      
      public function getSubConnection(idOrMessageOrEvent:*=null) : IServerConnection {
         if(idOrMessageOrEvent is String)
         {
            return this._connectionById[idOrMessageOrEvent];
         }
         if(idOrMessageOrEvent is Message)
         {
            return this._connectionByMsg[idOrMessageOrEvent];
         }
         if(idOrMessageOrEvent is Event)
         {
            return this._connectionByEvent[idOrMessageOrEvent];
         }
         throw new TypeError("Can\'t handle " + idOrMessageOrEvent + " class");
      }
      
      public function getConnectionId(idOrMessageOrEvent:*=null) : String {
         var conn:IServerConnection = this.getSubConnection(idOrMessageOrEvent);
         return this._idByConnection[conn];
      }
      
      public function getPauseBuffer(id:String=null) : Array {
         var mergedPauseBuffer:Array = null;
         var conn:IServerConnection = null;
         if((id) && (this._connectionById[id]))
         {
            return IServerConnection(this._connectionById[id]).pauseBuffer;
         }
         if(!id)
         {
            mergedPauseBuffer = [];
            for each (conn in this._connectionById)
            {
               mergedPauseBuffer = mergedPauseBuffer.concat(conn.pauseBuffer);
            }
            return mergedPauseBuffer;
         }
         return null;
      }
      
      public function close(id:String=null) : void {
         var connection:IServerConnection = null;
         if(id)
         {
            if(this._connectionById[id])
            {
               IServerConnection(this._connectionById[id]).close();
            }
            return;
         }
         for each (connection in this._connectionById)
         {
            connection.close();
         }
      }
      
      public function pause(id:String=null) : void {
         var connection:IServerConnection = null;
         if(id)
         {
            if(this._connectionById[id])
            {
               IServerConnection(this._connectionById[id]).pause();
            }
            return;
         }
         for each (connection in this._connectionById)
         {
            connection.pause();
         }
      }
      
      public function resume(id:String=null) : void {
         var connection:IServerConnection = null;
         if(id)
         {
            if(this._connectionById[id])
            {
               IServerConnection(this._connectionById[id]).resume();
            }
            return;
         }
         for each (connection in this._connectionById)
         {
            connection.resume();
         }
      }
      
      public function send(msg:INetworkMessage) : void {
         if(this._messageRouter)
         {
            this.getSubConnection(this._messageRouter.getConnectionId(msg)).send(msg);
         }
         else
         {
            if(this._mainConnection)
            {
               this._mainConnection.send(msg);
            }
         }
         if(hasEventListener(NetworkSentEvent.EVENT_SENT))
         {
            dispatchEvent(new NetworkSentEvent(NetworkSentEvent.EVENT_SENT,msg));
         }
      }
      
      private function proccessMsg(msg:Message, conn:IServerConnection) : void {
         this._connectionByMsg[msg] = conn;
      }
      
      private function onSubConnectionEvent(e:Event) : void {
         switch(e.type)
         {
            case Event.CONNECT:
               this._connectionConnectedCount++;
               break;
            case Event.CLOSE:
               this._connectionConnectedCount--;
               break;
         }
         this._connectionByEvent[e] = e.target as IServerConnection;
         dispatchEvent(e);
      }
   }
}
import com.ankamagames.jerakine.messages.MessageHandler;
import com.ankamagames.jerakine.network.IServerConnection;
import com.ankamagames.jerakine.messages.Message;

class MessageWatcher extends Object implements MessageHandler
{
   
   function MessageWatcher(watchFunction:Function, handler:MessageHandler, conn:IServerConnection) {
      super();
      this.watchFunction = watchFunction;
      this.handler = handler;
      this.conn = conn;
   }
   
   public var watchFunction:Function;
   
   public var handler:MessageHandler;
   
   public var conn:IServerConnection;
   
   public function process(msg:Message) : Boolean {
      this.watchFunction(msg,this.conn);
      return this.handler.process(msg);
   }
}
