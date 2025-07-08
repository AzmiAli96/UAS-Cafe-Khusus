import { User } from "@prisma/client";
import { db } from "../config/prisma";
import { BcryptUtil } from "../utils";


export class UserRepository {
    static async findById(id: string): Promise<User | null> {
        return db.user.findUnique({
            where: { id }
        })
    }

    static async findByEmail(email: string, ignoreUserId?: string): Promise<User | null> {
        return db.user.findFirst({
            where: {
                email,
                ...(ignoreUserId ?
                    { NOT: { id: ignoreUserId } }
                    : {}),
            }
        })
    }

    static async create(data: Pick<User, 'name' | 'email' | 'password' | 'role'>): Promise<User> {
        return db.user.create({
            data,
        });
    }

    static async update(id: string, data: Partial<Pick<User, 'name' | 'password' | 'email' | 'role'>>): Promise<User> {
        return db.user.update({
            where: { id },
            data: {
                name: data.name,
                email: data.email,
                password: data.password ? await BcryptUtil.hash(data.password) : undefined,
                role: data.role || 'user',
            },
        });
    }

    static async delete(id: string): Promise<User> {
        return db.user.delete({
            where: { id },
        });
    }

    static async findAll(): Promise<User[]> {
        return db.user.findMany();
    }
}