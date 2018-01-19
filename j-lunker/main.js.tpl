"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
var platform_browser_dynamic_1 = require("@angular/platform-browser-dynamic");
var core_1 = require("@angular/core");
var platform_browser_1 = require("@angular/platform-browser");
var animations_1 = require("@angular/platform-browser/animations");
var http_1 = require("@angular/common/http");
var jigsaw_1 = require("@rdkmaster/jigsaw");
var ajax_interceptor_ts_1 = require("ajax-interceptor.ts");
var app_module_1 = require("app/app.module");
var AppComponent = /** @class */ (function () {
    function AppComponent() {
    }
    AppComponent = __decorate([
        core_1.Component({
            selector: 'demo-root',
            template: '<jigsaw-root><jigsaw-live-demo></jigsaw-live-demo></jigsaw-root>'
        })
    ], AppComponent);
    return AppComponent;
}());
exports.AppComponent = AppComponent;
var AppModule = /** @class */ (function () {
    function AppModule() {
    }
    AppModule = __decorate([
        core_1.NgModule({
            declarations: [AppComponent],
            bootstrap: [AppComponent],
            providers: [
                {
                    provide: http_1.HTTP_INTERCEPTORS,
                    useClass: ajax_interceptor_ts_1.AjaxInterceptor,
                    multi: true,
                },
            ],
            imports: [
                platform_browser_1.BrowserModule, animations_1.BrowserAnimationsModule, http_1.HttpClientModule,
                jigsaw_1.JigsawRootModule, app_module_1./* to-be-replaced-with-demo-module-name */
            ]
        })
    ], AppModule);
    return AppModule;
}());
exports.AppModule = AppModule;
platform_browser_dynamic_1.platformBrowserDynamic().bootstrapModule(AppModule);
