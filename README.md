## todos
### todo1: import contacts

* https://github.com/glennfu/contacts
* https://github.com/Diego81/omnicontacts
* http://rtdptech.com/2010/12/importing-gmail-contacts-list-to-rails-application/

## 用户中心(UC)原理

假设有[A,B,C]三个应用

### 场景1: 用户在子应用A登陆

那么，后端A向UC发送类似如下的请求

```
m=user&a=synlogin&inajax=2&release=20110501&input=3cf7iupgX8esG6FSue%2FTOI2%2B4VQZKBHY9CCG3vHa8Q0j038yhZ%2F9%2FPPjos3KLLVnEFazb9UWYhlpb2VGqWWyDqfG%2F9YRBoTZjJMzjSf7ubFzl3nwemnWoOQ%3D&appid=1
```

UC返回A,B,C三个应用的登陆API调用js

```
<script type="text/javascript" src="http://A/api/uc.php?time=1345699241&code=2831ua%2Bn%2FJatGtF3lAaGvpirFDQRPJthk2D8RS1BG%2FzL1LbDiREyezhLbvvO2ZqrdQMCxtIPFHnB2M71h%2Bja%2FLFhHopaN%2FWPGZlu7cBW2LfzzsQib9%2FTIwdM92DPk0SgeC4Wu5zAR6e1V2PP4gzjjwMyjWavGqr55MU%3D" reload="1"></script>
<script type="text/javascript" src="http://B/api/uc?time=1345699241&code=aca6l4dsglAMdn7oBhEaTU%2F8OVyIFsxCnXRsRMszPXqf3VfQArQkmlJoYZRVeRxW20H9yNXSe9xzn5GANgJMg68xAibSjIHjne3E3RorclQBp0voNGs3dwp9hZ%2FcAybni8%2FTU62ekfNjSGeenk5HGVZhUZrxyGuLCXk%3D" reload="1"></script>
<script type="text/javascript" src="http://C/api/uc?time=1345699241&code=aca6l4dsglAMdn7oBhEaTU%2F8OVyIFsxCnXRsRMszPXqf3VfQArQkmlJoYZRVeRxW20H9yNXSe9xzn5GANgJMg68xAibSjIHjne3E3RorclQBp0voNGs3dwp9hZ%2FcAybni8%2FTU62ekfNjSGeenk5HGVZhUZrxyGuLCXk%3D" reload="1"></script>
```

A向前台用户展示并执行此JS，A可选地此时可能已经完成登陆，或等待A/api的进一步调用；B和C则只能依赖客户端对B/api和C/api的进一步调用，为了不让客户等待太久，此处B/api和C/api的处理时间有限，并不能一定保证登陆成功，这样做同时降低耦合，提高容错能力。但是这样在B/api和C/api中还要再进一步读取A下产生的cookie，以100%保证登陆。

### 场景2:用户在子应用A退出

类似场景1，会有清理请求发送到A,B,C的API。但这里不同于场景1，不能使用超时跳转的策略，此时必须完全清理A与B与C的cookie，或强制等待直到清理完毕，以防止泄漏用户信息。

