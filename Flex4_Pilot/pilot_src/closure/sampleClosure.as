package closure{
	import flash.events.Event;
	
	public function sampleClosure(e:Event = null):void {
	    trace("package level function closure be invoked");
	}
}

/**
 *Source-file-level function
 *it can be used anywhere within this file, but is inaccessible to code
 *outside of this file
 * access-control modifiers(public private etc) can't be included
 */
function sourceFileLevel():void {
	trace("this is sourcr file level function");
}
