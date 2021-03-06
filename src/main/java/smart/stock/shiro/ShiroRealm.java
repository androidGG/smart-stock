package smart.stock.shiro;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.PasswordMatcher;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Set;

/**
 * @Auther: sunjx
 * @Date: 2019/3/7 0007 17:09
 * @Description:
 */
@Slf4j
@Component
public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private ShiroService shiroService;

    //告诉shiro如何根据获取到的用户信息中的密码和盐值来校验密码
    {
        //设置用于匹配密码的CredentialsMatcher
        this.setCredentialsMatcher(new PasswordMatcher());
    }

    //定义如何获取用户的角色和权限的逻辑，给shiro做权限判断
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        if (principals == null) {
            throw new AuthorizationException("手机号不能为空");
        }
        ShiroUser user = (ShiroUser) getAvailablePrincipal(principals);
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(user.getRoles());
        info.setStringPermissions(user.getPerms());
        return info;
    }

    //定义如何获取用户信息的业务逻辑，给shiro做登录
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        String username = upToken.getUsername();

        if (username == null) {
            throw new AccountException("手机号不能为空");
        }

        ShiroUser userDB = shiroService.findUserByPhone(username);

        if (userDB == null) {
            throw new UnknownAccountException("用户不存在");
        }

        //查询用户的角色和权限存到SimpleAuthenticationInfo中，这样在其它地方
        //SecurityUtils.getSubject().getPrincipal()就能拿出用户的所有信息，包括角色和权限
        Set<String> roles = shiroService.getRolesByUserId(userDB.getId());
        Set<String> perms = shiroService.getPermsByUserId(userDB.getId());
        userDB.getRoles().addAll(roles);
        userDB.getPerms().addAll(perms);

        String prefix = "$shiro1$SHA-256$500000$";

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(userDB, prefix + userDB.getLoginSalt() + "$" + userDB.getLoginPwd(), getName());
//        if (userDB.getLoginSalt() != null) {
//            info.setCredentialsSalt(ByteSource.Util.bytes(userDB.getLoginSalt()));
//        }

        return info;
    }
}
