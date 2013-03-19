local memcached = require "resty.memcached"

local memc, err = memcached:new()
if not memc then
   ngx.say("failed to instantiate memc: ", err)
   return
end

memc:set_timeout(250)

local ok, err = memc:connect("127.0.0.1", 11211)
if not ok then
   ngx.log("something")
   ngx.say("failed to connect: ", err)
   return
end

sitename = 'localhost'
prefix_key = "p:" .. sitename
ngx.log(ngx.ERR,'*' .. prefix_key .. '*')

memc:set('test','hello',0)

local res, flags, err = memc:get(prefix_key)

if err then
   ngx.log("something")
   ngx.exit(404)
   return
end

if not res then
   ngx.log(ngx.ERR,"no prefix for " .. prefix_key)
   ngx.exit(404)
   return
end


ngx.say (res)

