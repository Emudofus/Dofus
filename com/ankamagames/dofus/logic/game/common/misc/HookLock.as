package com.ankamagames.dofus.logic.game.common.misc
{
    import __AS3__.vec.Vector;
    import com.ankamagames.berilia.types.data.Hook;
    import __AS3__.vec.*;

    public class HookLock implements IHookLock 
    {

        private var _hooks:Vector.<HookDef>;

        public function HookLock()
        {
            this._hooks = new Vector.<HookDef>();
        }

        public function addHook(hook:Hook, args:Array):void
        {
            var hd:HookDef;
            var hookDef:HookDef = new HookDef(hook, args);
            for each (hd in this._hooks)
            {
                if (hookDef.isEqual(hd))
                {
                    return;
                };
            };
            this._hooks.push(hookDef);
        }

        public function release():void
        {
            var hd:HookDef;
            for each (hd in this._hooks)
            {
                hd.run();
            };
            this._hooks.splice(0, this._hooks.length);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.misc

import com.ankamagames.berilia.types.data.Hook;
import com.ankamagames.berilia.managers.KernelEventsManager;

class HookDef 
{

    /*private*/ var _hook:Hook;
    /*private*/ var _args:Array;

    public function HookDef(hook:Hook, args:Array)
    {
        this._hook = hook;
        this._args = args;
    }

    public function get hook():Hook
    {
        return (this._hook);
    }

    public function get args():Array
    {
        return (this._args);
    }

    public function isEqual(compareTo:HookDef):Boolean
    {
        if (this.hook != compareTo.hook)
        {
            return (false);
        };
        if (this.args.length != compareTo.args.length)
        {
            return (false);
        };
        var i:int;
        while (i < this.args.length)
        {
            if (this.args[i] != compareTo.args[i])
            {
                return (false);
            };
            i++;
        };
        return (true);
    }

    public function run():void
    {
        switch (this.args.length)
        {
            case 0:
                KernelEventsManager.getInstance().processCallback(this.hook);
                return;
            case 1:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0]);
                return;
            case 2:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1]);
                return;
            case 3:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2]);
                return;
            case 4:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3]);
                return;
            case 5:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4]);
                return;
            case 6:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5]);
                return;
            case 7:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5], this.args[6]);
                return;
            case 8:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5], this.args[6], this.args[7]);
                return;
            case 9:
                KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5], this.args[6], this.args[7], this.args[8]);
                return;
        };
    }


}

