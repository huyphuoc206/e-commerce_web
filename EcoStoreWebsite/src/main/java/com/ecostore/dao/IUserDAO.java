package com.ecostore.dao;

import com.ecostore.model.UserModel;


public interface IUserDAO {
    UserModel findOneByUsernameAndPasswordAndStatus(String username, String password, int status);

    Long insert(UserModel user);

    boolean update(UserModel user);

    UserModel findOneByUsernameAndEmail(String username, String email);

    UserModel findOneById(Long id);

    UserModel findOneByEmail(String email);

    boolean resetPassword(long userId, String newPassword);
}
