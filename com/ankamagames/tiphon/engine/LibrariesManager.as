package com.ankamagames.tiphon.engine
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.impl.InfiniteCache;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import __AS3__.vec.Vector;
   import flash.utils.Timer;
   import com.ankamagames.tiphon.types.GraphicLibrary;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.tiphon.types.AnimLibrary;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.events.SwlEvent;
   import flash.events.Event;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;


   public class LibrariesManager extends EventDispatcher
   {
         

      public function LibrariesManager(n:String, type:uint) {
         this._waitingResources=new Vector.<Uri>();
         this._libCurrentlyUsed=new Dictionary(true);
         super();
         this.name=n;
         this._aResources=new Dictionary();
         this._aResourceLoadFail=new Dictionary();
         this._aResourceStates=new Array();
         this._aWaiting=new Array();
         this._loader=ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoadResource);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadFailedResource);
         this._type=type;
         numLM++;
      }

      private static const _log:Logger = Log.getLogger(getQualifiedClassName(LibrariesManager));

      public static const TYPE_BONE:uint = 0;

      public static const TYPE_SKIN:uint = 1;

      private static var _cache:InfiniteCache = new InfiniteCache();

      private static var _uri:Uri;

      private static var numLM:int = 0;

      private var _aResources:Dictionary;

      private var _aResourceLoadFail:Dictionary;

      private var _aResourcesUri:Array;

      private var _aResourceStates:Array;

      private var _aWaiting:Array;

      private var _loader:IResourceLoader;

      private var _waitingResources:Vector.<Uri>;

      private var _type:uint;

      private var _GarbageCollectorTimer:Timer;

      private var _currentCacheSize:int = 0;

      private var _libCurrentlyUsed:Dictionary;

      public var name:String;

      public function addResource(id:uint, uri:Uri) : void {
         var gl:GraphicLibrary = null;
         if(uri==null)
         {
            uri=new Uri(TiphonConstants.SWF_SKULL_PATH+"666.swl");
         }
         if(!this._aResources[id])
         {
            if(this._type==TYPE_BONE)
            {
               gl=new AnimLibrary(id,true);
            }
            else
            {
               gl=new GraphicLibrary(id,false);
            }
            this._aResources[id]=gl;
         }
         else
         {
            gl=this._aResources[id];
         }
         if(!gl.hasSwl(uri))
         {
            if(uri.tag==null)
            {
               uri.tag=new Object();
            }
            uri.tag.id=id;
            _log.info("["+this.name+"] Load "+uri);
            gl.updateSwfState(uri);
            this._waitingResources.push(uri);
         }
      }

      public function askResource(id:uint, className:String, callback:Callback, errorCallback:Callback=null) : void {
         var gl:GraphicLibrary = null;
         var waitCallback:Array = null;
         var ok:* = false;
         var c:Callback = null;
         var allMatch:* = false;
         var index:uint = 0;
         if(!this.hasResource(id,className))
         {
            _log.error("Tiphon cache does not contains ressource "+id);
         }
         else
         {
            gl=this._aResources[id];
            if(gl.hasClassAvaible(className))
            {
               callback.exec();
            }
            else
            {
               if(!this._aWaiting[id])
               {
                  this._aWaiting[id]=new Object();
                  this._aWaiting[id]["ok"]=new Array();
                  this._aWaiting[id]["ko"]=new Array();
               }
               waitCallback=this._aWaiting[id]["ok"];
               ok=true;
               loop0:
               for(;waitCallback hasNext _loc11_;if(allMatch)
               {
                  ok=false;
                  break;
                  })
                  {
                     c=nextValue(_loc11_,_loc12_);
                     if((c.method==callback.method)&&(callback.args.length==c.args.length))
                     {
                        allMatch=true;
                        while(index<c.args.length)
                        {
                           if(c.args[index]!=callback.args[index])
                           {
                              allMatch=false;
                              continue loop0;
                           }
                           index++;
                        }
                     }
                  }
                  if(ok)
                  {
                     this._aWaiting[id]["ok"].push(callback);
                  }
                  if(errorCallback)
                  {
                     this._aWaiting[id]["ko"].push(errorCallback);
                  }
                  while(this._waitingResources.length)
                  {
                     this._loader.load(this._waitingResources.shift(),_cache);
                  }
               }
            }
      }

      public function removeResource(id:uint) : void {
         if(this._aWaiting[id])
         {
            delete this._aWaiting[[id]];
         }
         delete this._aResources[[id]];
      }

      public function isLoaded(id:uint, animClass:String=null) : Boolean {
         if(this._aResources[id]==false)
         {
            return false;
         }
         var lib:GraphicLibrary = this._aResources[id];
         if(animClass)
         {
            return (!(lib==null))&&(lib.hasClassAvaible(animClass));
         }
         return (lib)&&(!(lib.getSwl()==null));
      }

      public function hasError(id:uint) : Boolean {
         return this._aResourceLoadFail[id];
      }

      public function hasResource(id:uint, animClass:String=null) : Boolean {
         var lib:GraphicLibrary = this._aResources[id];
         return (lib)&&(lib.hasClass(animClass));
      }

      public function getResourceById(resName:uint, animClass:String=null, waitForIt:Boolean=false) : Swl {
         var swl:Swl = null;
         var lib:GraphicLibrary = this._aResources[resName];
         if((lib.isSingleFile)&&(!waitForIt))
         {
            swl=lib.getSwl(null);
         }
         swl=lib.getSwl(animClass,waitForIt);
         if((swl==null)&&(waitForIt))
         {
            lib.addEventListener(SwlEvent.SWL_LOADED,this.onSwfLoaded);
         }
         return swl;
      }

      private function onSwfLoaded(pEvt:Event) : void {
         pEvt.currentTarget.removeEventListener(SwlEvent.SWL_LOADED,this.onSwfLoaded);
         dispatchEvent(pEvt);
      }

      public function hasAnim(bonesId:int, animName:String, direction:int=-1) : Boolean {
         var animIzHere:* = false;
         var swldefanim:String = null;
         var lib:GraphicLibrary = this._aResources[bonesId];
         if(lib.isSingleFile)
         {
            animIzHere=false;
            if(!lib.getSwl())
            {
               _log.warn("/!\\ Attention, on test si une librairie contient une anim sans l\'avoir en mémoire. (bones: "+bonesId+", anim:"+animName+")");
               return false;
            }
            for each (swldefanim in lib.getSwl().getDefinitions())
            {
               if(swldefanim.indexOf(animName+(!(direction==-1)?"_"+direction:""))==0)
               {
                  animIzHere=true;
               }
            }
            return animIzHere;
         }
         return BoneIndexManager.getInstance().hasAnim(bonesId,animName,direction);
      }

      private function onLoadResource(re:ResourceLoadedEvent) : void {
         var size:uint = 0;
         var i:uint = 0;
         var tagId:int = re.uri.tag.id==null?re.uri.tag:re.uri.tag.id;
         _log.info("Loaded "+re.uri);
         GraphicLibrary(this._aResources[tagId]).addSwl(re.resource,re.uri.uri);
         if((this._aWaiting[tagId])&&(this._aWaiting[tagId]["ok"]))
         {
            size=this._aWaiting[tagId]["ok"].length;
            i=0;
            while(i<size)
            {
               Callback(this._aWaiting[tagId]["ok"][i]).exec();
               i++;
            }
            delete this._aWaiting[[tagId]];
         }
      }

      private function onLoadFailedResource(re:ResourceErrorEvent) : void {
         var callBackList:Array = null;
         var num:* = 0;
         var i:* = 0;
         var tagId:int = isNaN(re.uri.tag)?re.uri.tag.id:re.uri.tag;
         _log.error("Unable to load "+re.uri+" ("+re.errorMsg+")");
         delete this._aResources[[tagId]];
         this._aResourceLoadFail[tagId]=true;
         this.addResource(tagId,_uri);
         if(this._aWaiting[tagId])
         {
            callBackList=this._aWaiting[tagId]["ko"];
            if(callBackList)
            {
               num=callBackList.length;
               i=0;
               while(i<num)
               {
                  (callBackList[i] as Callback).exec();
                  i++;
               }
               delete this._aWaiting[[tagId]];
            }
         }
      }
   }

}